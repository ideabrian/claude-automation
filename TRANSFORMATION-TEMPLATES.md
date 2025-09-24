# 🎯 Project Transformation Templates

Pre-made prompts for common project transformations.

## 🎰 File Sharing → Prediction Market (like futr-bet)

```bash
# From: File sharing platform
# To: Prediction market for friends

COMPONENTS TO TRANSFORM:
- ShareFiles.tsx → MarketCreator.tsx
- FileUpload → BetPlacement
- FileList → MarketList
- ShareModal → InviteFriends

DATA MODEL:
- files → markets (question, options, end_date)
- uploads → bets (user, amount, option)
- receivers → participants

UI CHANGES:
- Upload area → Market creation form
- File grid → Active markets grid
- Share link → Invite to market
```

## 🛍️ File Sharing → E-Commerce

```bash
# From: File sharing
# To: Simple store

COMPONENTS:
- ShareFiles.tsx → ProductCatalog.tsx
- FileUpload → AddToCart
- FileList → ProductGrid
- ShareModal → CheckoutModal

DATA MODEL:
- files → products (name, price, image)
- uploads → cart_items
- receivers → orders
```

## 📝 File Sharing → Survey Platform

```bash
# From: File sharing
# To: Survey/form builder

COMPONENTS:
- ShareFiles.tsx → SurveyBuilder.tsx
- FileUpload → QuestionCreator
- FileList → ResponseViewer
- ShareModal → ShareSurvey

DATA MODEL:
- files → surveys
- uploads → responses
- receivers → respondents
```

## 💬 File Sharing → Chat Application

```bash
# From: File sharing
# To: Real-time chat

COMPONENTS:
- ShareFiles.tsx → ChatRoom.tsx
- FileUpload → MessageInput
- FileList → MessageHistory
- ShareModal → InviteToRoom

DATA MODEL:
- files → messages
- uploads → attachments
- receivers → chat_rooms
```

## 📅 File Sharing → Event Planner

```bash
# From: File sharing
# To: Event management

COMPONENTS:
- ShareFiles.tsx → EventCreator.tsx
- FileUpload → RSVPForm
- FileList → EventList
- ShareModal → SendInvites

DATA MODEL:
- files → events
- uploads → rsvps
- receivers → attendees
```

## 📊 File Sharing → Dashboard/Analytics

```bash
# From: File sharing
# To: Analytics dashboard

COMPONENTS:
- ShareFiles.tsx → Dashboard.tsx
- FileUpload → DataImporter
- FileList → MetricsGrid
- ShareModal → ShareReport

DATA MODEL:
- files → datasets
- uploads → metrics
- receivers → reports
```

## 🎮 File Sharing → Game Platform

```bash
# From: File sharing
# To: Multiplayer game

COMPONENTS:
- ShareFiles.tsx → GameLobby.tsx
- FileUpload → MoveInput
- FileList → Leaderboard
- ShareModal → InvitePlayer

DATA MODEL:
- files → games
- uploads → moves
- receivers → players
```

## 📚 File Sharing → Knowledge Base

```bash
# From: File sharing
# To: Documentation wiki

COMPONENTS:
- ShareFiles.tsx → ArticleEditor.tsx
- FileUpload → ContentCreator
- FileList → ArticleList
- ShareModal → ShareArticle

DATA MODEL:
- files → articles
- uploads → revisions
- receivers → contributors
```

## 🏦 File Sharing → Finance Tracker

```bash
# From: File sharing
# To: Expense tracking

COMPONENTS:
- ShareFiles.tsx → TransactionEntry.tsx
- FileUpload → AddExpense
- FileList → TransactionHistory
- ShareModal → ShareReport

DATA MODEL:
- files → transactions
- uploads → receipts
- receivers → budgets
```

## 🎯 Using These Templates

### Method 1: Quick Transform
```bash
# Copy project
cp -R source-project new-project
cd new-project

# Run transformer
transform

# When prompted, paste the template description
```

### Method 2: Clone & Transform
```bash
# One command
clone-transform fastfiles my-new-app

# Follow prompts, use template as guide
```

### Method 3: With Claude
```bash
# After running transform, paste to Claude:
"Transform this using the E-Commerce template from TRANSFORMATION-TEMPLATES.md"
```

## 🔄 Transformation Process

1. **Automated** (by script):
   - Renames project
   - Updates package.json
   - Replaces strings
   - Cleans old files

2. **Claude Completes** (with template):
   - Refactors components
   - Updates UI/UX
   - Implements new features
   - Adjusts backend

## 💡 Pro Tips

1. **Keep Infrastructure**: CloudFlare Workers, R2, D1 work for any app
2. **Reuse Auth**: Magic links work everywhere
3. **Maintain Patterns**: Same component structure, different purpose
4. **Test Early**: Get basic version working, then enhance

## 🚀 Quick Starts

### Betting Platform
```bash
clone-transform fastfiles bet-with-friends
# Use Prediction Market template
```

### Online Store
```bash
clone-transform fastfiles quick-shop
# Use E-Commerce template
```

### Survey Tool
```bash
clone-transform fastfiles easy-surveys
# Use Survey Platform template
```

---

*These templates turn any project into something new in minutes!*