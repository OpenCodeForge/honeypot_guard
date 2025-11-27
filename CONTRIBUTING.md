# 🤝 Contributing

Thanks for your interest in contributing to **HoneypotGuard** 🛡️

---

## 🧪 Use the gem locally

To test the gem in a Rails project, add it via a local path.

In your Rails app `Gemfile`:

```ruby
gem "honeypot_guard", path: "../honeypot_guard"
```

Then run:

```bash
bundle install
```

You can now use the gem normally in your views and controllers.

---

## ✅ Run the tests

Install dependencies:

```bash
bundle install
```

Run the test suite:

```bash
bundle exec rspec
```

### 🚆 Test against a specific Rails version

```bash
BUNDLE_GEMFILE=gemfiles/rails_7.2.gemfile bundle exec rspec
BUNDLE_GEMFILE=gemfiles/rails_8.0.gemfile bundle exec rspec
```

---

## 📦 Contributing guidelines

- 🔍 Keep changes small and focused
- 🧪 Add tests when changing behavior
- ✅ Make sure all tests pass before opening a PR

Thank you for contributing 🙂❤️
