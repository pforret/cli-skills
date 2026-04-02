#!/usr/bin/env python3
"""Take a screenshot of a URL using Playwright (headless Chromium)."""

import argparse
import sys
from pathlib import Path


def parse_args():
    parser = argparse.ArgumentParser(
        description="Screenshot a URL with Playwright",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s https://example.com out.png
  %(prog)s https://example.com mobile.png --width 390 --height 844
  %(prog)s https://example.com hero.png --selector "#hero"
  %(prog)s https://example.com fold.png --no-full-page
""",
    )
    parser.add_argument("url", help="URL to screenshot")
    parser.add_argument("output", help="Output PNG file path")
    parser.add_argument("--width", type=int, default=1280, help="Viewport width (default: 1280)")
    parser.add_argument("--height", type=int, default=800, help="Viewport height (default: 800)")
    parser.add_argument("--selector", help="CSS selector to capture (captures element only)")
    parser.add_argument(
        "--full-page",
        dest="full_page",
        action="store_true",
        default=True,
        help="Capture full scrollable page (default)",
    )
    parser.add_argument(
        "--no-full-page",
        dest="full_page",
        action="store_false",
        help="Capture visible viewport only",
    )
    parser.add_argument(
        "--wait",
        type=int,
        default=0,
        help="Extra milliseconds to wait after page load (default: 0)",
    )
    parser.add_argument(
        "--timeout",
        type=int,
        default=30000,
        help="Navigation timeout in milliseconds (default: 30000)",
    )
    return parser.parse_args()


def main():
    args = parse_args()

    try:
        from playwright.sync_api import sync_playwright
    except ImportError:
        print("error: playwright not installed — run setup.sh first", file=sys.stderr)
        sys.exit(1)

    output = Path(args.output)
    output.parent.mkdir(parents=True, exist_ok=True)

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        context = browser.new_context(
            viewport={"width": args.width, "height": args.height},
        )
        page = context.new_page()

        try:
            page.goto(args.url, timeout=args.timeout, wait_until="networkidle")
        except Exception as e:
            print(f"error: failed to load {args.url!r}: {e}", file=sys.stderr)
            browser.close()
            sys.exit(1)

        if args.wait > 0:
            page.wait_for_timeout(args.wait)

        if args.selector:
            try:
                element = page.locator(args.selector).first
                element.screenshot(path=str(output))
            except Exception as e:
                print(f"error: selector {args.selector!r} not found: {e}", file=sys.stderr)
                browser.close()
                sys.exit(1)
        else:
            page.screenshot(path=str(output), full_page=args.full_page)

        browser.close()

    print(f"saved: {output.resolve()}")


if __name__ == "__main__":
    main()
