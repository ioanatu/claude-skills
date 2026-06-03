---
name: create-react-app
description: Scaffold a React app with latest Yarn Berry, Vite, TypeScript, Vitest, and ESLint accessibility
argument-hint: <project-name>
---

# Create React App

Scaffold a production-ready React application. The project name is: `$ARGUMENTS`

If no project name was provided, ask the user for one before proceeding.

## Stack

- **Vite** — build tool and dev server
- **React + TypeScript** — via the official `react-ts` Vite template
- **Yarn Berry (v4)** — latest stable Yarn via Corepack
- **Vitest** — unit tests with React Testing Library and jsdom
- **ESLint + eslint-plugin-jsx-a11y** — accessibility linting rules

---

## Step 1 — Scaffold the Vite project

Run the following from the parent directory where the project should be created:

```bash
yarn create vite $ARGUMENTS --template react-ts
```

Then move into the project:

```bash
cd $ARGUMENTS
```

---

## Step 2 — Upgrade to Yarn Berry (latest stable)

Enable Corepack (ships with Node.js 16.9+) and pin the project to the latest stable Yarn:

```bash
corepack enable
yarn set version stable
```

This writes a `packageManager` field to `package.json` and creates a `.yarn/` directory. Then install dependencies:

```bash
yarn install
```

---

## Step 3 — Add Vitest and React Testing Library

Install test dependencies:

```bash
yarn add -D vitest @vitest/ui jsdom @testing-library/react @testing-library/jest-dom @types/node
```

Update `vite.config.ts` to add the test configuration block. Read the file first, then replace the export with:

```ts
/// <reference types="vitest" />
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  test: {
    globals: true,
    environment: "jsdom",
    setupFiles: ["./vitest.setup.ts"],
    coverage: {
      provider: "v8",
      reporter: ["text", "lcov"],
    },
  },
});
```

Create `vitest.setup.ts` in the project root:

```ts
import "@testing-library/jest-dom";
```

Update `tsconfig.app.json` (or `tsconfig.json` if that's the only one) to include the vitest globals type. Add `"types": ["vitest/globals"]` inside `compilerOptions`. Read the file first to avoid overwriting.

Add test scripts to `package.json`:

```json
"test": "vitest",
"test:ui": "vitest --ui",
"test:run": "vitest run",
"coverage": "vitest run --coverage"
```

---

## Step 4 — Add ESLint accessibility plugin

Install the plugin:

```bash
yarn add -D eslint-plugin-jsx-a11y
```

Read the existing `eslint.config.js` that Vite generated, then update it to integrate `jsx-a11y`. The final file should look like this:

```js
import js from "@eslint/js";
import globals from "globals";
import reactHooks from "eslint-plugin-react-hooks";
import reactRefresh from "eslint-plugin-react-refresh";
import tseslint from "typescript-eslint";
import jsxA11y from "eslint-plugin-jsx-a11y";

export default tseslint.config(
  { ignores: ["dist"] },
  {
    extends: [js.configs.recommended, ...tseslint.configs.recommended],
    files: ["**/*.{ts,tsx}"],
    languageOptions: {
      ecmaVersion: 2020,
      globals: globals.browser,
    },
    plugins: {
      "react-hooks": reactHooks,
      "react-refresh": reactRefresh,
      "jsx-a11y": jsxA11y,
    },
    rules: {
      ...reactHooks.configs.recommended.rules,
      "react-refresh/only-export-components": [
        "warn",
        { allowConstantExport: true },
      ],
      ...jsxA11y.configs.recommended.rules,
    },
  },
);
```

---

## Step 5 — Verify the setup

Run each of these commands and confirm they succeed before reporting completion:

```bash
yarn lint
yarn test:run
yarn build
```

If any command fails, diagnose and fix the issue before continuing.

---

## Step 6 — Report

Tell the user:

- The project was created at `./$ARGUMENTS`
- The commands available: `yarn dev`, `yarn build`, `yarn test`, `yarn test:ui`, `yarn coverage`, `yarn lint`
- Any warnings or deviations from the expected setup
