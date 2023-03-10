import 'package:money_goes_brr/home/model/post.dart';

class User {
  String name;
  String email;
  String caption;
  String imageUrl;
  Profit profit;
  Balance currentBalance;
  History history;
  CurrentOwned currentOwned;
  Saved saved;
  String id;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.caption,
    required this.imageUrl,
    required this.profit,
    required this.currentBalance,
    required this.history,
    required this.currentOwned,
    required this.saved,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      caption: json['caption'],
      imageUrl: json['imageUrl'],
      profit: Profit.fromJson(json['profit']),
      currentBalance: Balance.fromJson(json['currentBalance']),
      history: History.fromJson(json['history']),
      currentOwned: CurrentOwned.fromJson(json['currentOwned']),
      saved: Saved.fromJson(json['saved']),
    );
  }
}

class Saved {
  final List<Post> savedItems;

  const Saved({
    required this.savedItems,
  });

  factory Saved.fromJson(Map<String, dynamic> json) {
    List<Post> savedItems = [];
    for (var item in json['savedItems']) {
      savedItems.add(Post.fromJson(item));
    }
    return Saved(
      savedItems: savedItems,
    );
  }
}


class CurrentOwned {
  final List<Post> currentOwnedItems;

  const CurrentOwned({
    required this.currentOwnedItems,
  });
  factory CurrentOwned.fromJson(Map<String, dynamic> json) {
    List<Post> currentOwnedItems = [];
    for (var item in json['currentOwnedItems']) {
      currentOwnedItems.add(Post.fromJson(item));
    }
    return CurrentOwned(
      currentOwnedItems: currentOwnedItems,
    );
  }
}

class History {
  final List<Post> historyItems;

  const History({
    required this.historyItems,
  });
  factory History.fromJson(List<dynamic> json) {
    List<Post> history = [];
    for (var item in json) {
      history.add(Post.fromJson(item));
    }
    return History(historyItems: history);
  }
}

class Balance {
  final double balance;
  final List<Transactions> transactions;

  const Balance({
    required this.balance,
    required this.transactions,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      balance: json['balance'].toDouble(),
      transactions: (json['transactions'] as List)
          .map((e) => Transactions.fromJson(e))
          .toList(),
    );
  }
}

class PostTransaction {
  final Post post;
  final Transactions purchase;
  final Transactions sale;
  final bool isSold;

  const PostTransaction({
    required this.post,
    required this.purchase,
    required this.sale,
    required this.isSold,
  });
  factory PostTransaction.fromJson(Map<String, dynamic> json) {
    return PostTransaction(
      post: Post.fromJson(json['post']),
      purchase: Transactions.fromJson(json['purchase']),
      sale: Transactions.fromJson(json['sale']),
      isSold: json['isSold'],
    );
  }
}

class Transactions {
  final String transactionId;

  final double transactionAmount;
  final DateTime transactionDate;
  final TransactionType transactionType;

  const Transactions({
    required this.transactionId,
    required this.transactionAmount,
    required this.transactionDate,
    required this.transactionType,
  });
  factory Transactions.fromJson(Map<String, dynamic> json) {
    return Transactions(
      transactionId: json['transactionId'],
      transactionAmount: json['transactionAmount'].toDouble(),
      transactionDate: DateTime.parse(json['transactionDate']),
      transactionType: _transactionTypeFromJson(json['transactionType']),
    );
  }

  static TransactionType _transactionTypeFromJson(String transactionType) {
    switch (transactionType) {
      case 'purchase':
        return TransactionType.added;
      case 'sale':
        return TransactionType.sold;
      case 'bought':
        return TransactionType.bought;
      default:
        return TransactionType.cashedOut;
    }
  }

}


enum TransactionType { added, bought, sold, cashedOut }

class Profit {
  final double profit;
  final List<PostTransaction> transactions;
// transactions is a list of transactions that are related to profit, like buying and selling items and not cashing out or adding money

  const Profit({
    required this.profit,
    required this.transactions,
  });
  factory Profit.fromJson(Map<String, dynamic> json) {
    return Profit(
      profit: json['profit'].toDouble(),
      transactions: (json['transactions'] as List)
          .map((transaction) => PostTransaction.fromJson(transaction))
          .toList(),
    );
  }

}
