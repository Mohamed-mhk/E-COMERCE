# Design System: Alex's Garage
**Project ID:** projects/13625223474990371188

## 1. Visual Theme & Atmosphere
The design is **Clean, Utilitarian, and Trustworthy**. It uses a high-contrast standard color scheme with a signature blue accent that conveys reliability (common in automotive). The layout is dense but organized, utilizing horizontal scrolling rails to manage information density on mobile. Surfaces are clean with subtle shadows, rising from a light gray background. Dark mode is fully supported with deep slate backgrounds.

## 2. Color Palette & Roles

### Core
*   **Primary Blue (#2b8cee):** Used for primary actions (Add to cart, Shop Now), icons in active states, and key highlights.
*   **Background Light (#f6f7f8):** The main canvas color in light mode.
*   **Background Dark (#101922):** The main canvas color in dark mode.
*   **Surface White (#ffffff):** Used for cards, headers, and navigation bars in light mode.
*   **Surface Dark (#1f2937):** Used for cards and containers in dark mode (Tailwind `gray-800`).

### Text
*   **Text Primary (#111827):** Main headings and strong body text (Tailwind `gray-900`).
*   **Text Secondary (#6b7280):** Supporting text, labels, and descriptions (Tailwind `gray-500`).
*   **Text Inverted (#ffffff):** Text on dark backgrounds (primary buttons, dark mode headers).

### Status
*   **Sale/Error Red (#ef4444):** Used for "Sale" badges, error states, and notification dots (Tailwind `red-500`).

## 3. Typography Rules
**Font Family:** `Inter`, sans-serif.

*   **Headings:** Bold (700) or SemiBold (600). Tight letter spacing.
*   **Body:** Regular (400) or Medium (500). Good readability.
*   **Labels/Buttons:** Medium (500) or Bold (700). Often categorized or uppercase for badges.

## 4. Component Stylings

*   **Buttons:**
    *   *Primary:* Rounded corners (8px-12px), primary blue background, white text, subtle shadow (`shadow-md`), optional icons.
    *   *Icon Buttons:* Circular or rounded-square, often with a slight background tint or shadow.
    *   *Category Chips:* Vertical stack of Icon (in rounded square container) + Label.

*   **Cards/Containers:**
    *   *Product Cards:* Rounded corners (12px/`rounded-xl`), white background, subtle border (`gray-100`), small shadow (`shadow-sm`). Content is vertically stacked: Image -> Title -> Subtitle -> Price/Action.
    *   *Banners:* High rounded corners (16px/`rounded-2xl`), full background image with gradient overlay for text readability.

*   **Inputs/Forms:**
    *   *Search Bar:* Pill-shaped or highly rounded (`rounded-xl`), light gray background (`#f3f4f6`), internal icon, no visible border but shadow on focus.

## 5. Layout Principles
*   **Grid:** 2-column grid for products with ~16px spacing.
*   **Scroll Rails:** Horizontal scrolling for Categories and Brands to save vertical space.
*   **Padding:** Standard 16px-24px (`px-6`) side padding for main content containers.
*   **Navigation:** Fixed bottom navigation bar with 4 distinct sections. Sticky top header with User profile and Cart.
