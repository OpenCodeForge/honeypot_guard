# 🛡️ HoneypotGuard

HoneypotGuard is a **minimal Rails gem** that protects web forms from basic spam using:

- 🍯 an invisible **honeypot field**
- ⏱️ a simple **minimum submission delay**

It works **at the controller level** (no model validations) and immediately rejects spam requests with **`422 Unprocessable Entity`**.

Perfect for ✉️ **contact forms**, 💬 feedback forms, and other **non-persisted submissions**.

---

## 📦 Installation

Add the gem to your Gemfile:

```ruby
gem "honeypot_guard"
```

Then run:

```bash
bundle install
```

---

## 🚀 Usage

### 1️⃣ Add spam trap fields to your form

Inside any `form_with` or `form_for` block:

```erb
<%= form_with url: contact_messages_path do |f| %>
  <%= spam_trap_fields %>

  <%= f.text_field :name %>
  <%= f.email_field :email %>
  <%= f.text_area :message %>
  <%= f.submit "Send" %>
<% end %>
```

This injects automatically:
- 🕳️ an invisible honeypot input
- 🧭 a hidden timestamp input

---

### 2️⃣ Enable spam filtering in the controller

Include the controller concern and add the `before_action`:

```ruby
class ContactMessagesController < ApplicationController
  include HoneypotGuard::Controller

  before_action :filter_spam, only: :create

  def create
    # normal processing
    redirect_to root_path, notice: "Message sent"
  end
end
```

If spam is detected, the request is immediately stopped with:

```http
422 Unprocessable Entity
```

---

## ⚙️ Configuration (Optional)

Create an initializer:

```ruby
# config/initializers/honeypot_guard.rb
HoneypotGuard.configure do |config|
  config.min_delay = 3            # seconds
  # config.honeypot_field = :website
  # config.timestamp_field = :rendered_at
end
```

---

## 🧠 How It Works

A request is considered spam if **any** of the following is true:

1. 🚨 The honeypot field is filled
2. ⚡ The form is submitted faster than the configured minimum delay

✅ No JavaScript  
✅ No model validation  
✅ No database access

---

## ⚠️ Limitations

HoneypotGuard is intentionally simple:

- ❌ Not effective against advanced bots or direct HTTP submissions
- ❌ Does not replace rate limiting or firewalls
- ✅ Best used alongside tools like **Rack::Attack**

---

## 📄 License

MIT License
