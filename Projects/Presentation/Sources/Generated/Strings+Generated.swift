// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  public enum Alert {
    public enum Unknown {
      /// Ошибка
      public static let title = Strings.tr("Localizable", "alert.unknown.title", fallback: "Ошибка")
    }
  }
  public enum App {
    /// Далее
    public static let next = Strings.tr("Localizable", "app.next", fallback: "Далее")
  }
  public enum Categories {
    /// Категории
    public static let systemTitle = Strings.tr("Localizable", "categories.systemTitle", fallback: "Категории")
  }
  public enum CreateCategory {
    /// Создать категорию
    public static let systemTitle = Strings.tr("Localizable", "createCategory.systemTitle", fallback: "Создать категорию")
    public enum Error {
      /// Введите корректные данные
      public static let segmentOrTextFieldIsIncorrect = Strings.tr("Localizable", "createCategory.error.segmentOrTextFieldIsIncorrect", fallback: "Введите корректные данные")
    }
    public enum Label {
      /// Название категории
      public static let title = Strings.tr("Localizable", "createCategory.label.title", fallback: "Название категории")
    }
    public enum Segment {
      /// Доход
      public static let income = Strings.tr("Localizable", "createCategory.segment.income", fallback: "Доход")
      /// Расход
      public static let spending = Strings.tr("Localizable", "createCategory.segment.spending", fallback: "Расход")
    }
    public enum Textfield {
      /// Название категории
      public static let title = Strings.tr("Localizable", "createCategory.textfield.title", fallback: "Название категории")
    }
  }
  public enum CreateWallet {
    /// Создать кошелек
    public static let systemTitle = Strings.tr("Localizable", "createWallet.systemTitle", fallback: "Создать кошелек")
    public enum Error {
      /// Баланс должен быть больше нуля
      public static let balanceLessThanZero = Strings.tr("Localizable", "createWallet.error.balanceLessThanZero", fallback: "Баланс должен быть больше нуля")
    }
    public enum Label {
      /// Баланс кошелька
      public static let balance = Strings.tr("Localizable", "createWallet.label.balance", fallback: "Баланс кошелька")
      /// Название кошелька
      public static let title = Strings.tr("Localizable", "createWallet.label.title", fallback: "Название кошелька")
    }
    public enum Textfield {
      /// Баланс кошелька
      public static let balance = Strings.tr("Localizable", "createWallet.textfield.balance", fallback: "Баланс кошелька")
      /// Название кошелька
      public static let title = Strings.tr("Localizable", "createWallet.textfield.title", fallback: "Название кошелька")
    }
  }
  public enum Credential {
    /// Регистрация
    public static let systemTitle = Strings.tr("Localizable", "credential.systemTitle", fallback: "Регистрация")
    public enum Error {
      /// Пустое имя
      public static let emptyName = Strings.tr("Localizable", "credential.error.emptyName", fallback: "Пустое имя")
    }
    public enum Textfield {
      public enum Name {
        /// Имя
        public static let placeholder = Strings.tr("Localizable", "credential.textfield.name.placeholder", fallback: "Имя")
      }
    }
  }
  public enum Error {
    /// Проверьте соединение с Интернетом или поробуйте позже
    public static let backend = Strings.tr("Localizable", "error.backend", fallback: "Проверьте соединение с Интернетом или поробуйте позже")
  }
  public enum Home {
    /// Главная
    public static let systemTitle = Strings.tr("Localizable", "home.systemTitle", fallback: "Главная")
  }
  public enum Onboarding {
    public enum Button {
      /// Далее
      public static let next = Strings.tr("Localizable", "onboarding.button.next", fallback: "Далее")
      /// Готово
      public static let ready = Strings.tr("Localizable", "onboarding.button.ready", fallback: "Готово")
    }
    public enum First {
      /// Get an overview of how you are performing and motivate yourself to achieve even more.
      public static let description = Strings.tr("Localizable", "onboarding.first.description", fallback: "Get an overview of how you are performing and motivate yourself to achieve even more.")
      /// You ought to know where your money goes
      public static let title = Strings.tr("Localizable", "onboarding.first.title", fallback: "You ought to know where your money goes")
    }
    public enum Second {
      /// Track your transaction easily, with categories and financial report
      public static let description = Strings.tr("Localizable", "onboarding.second.description", fallback: "Track your transaction easily, with categories and financial report")
      /// Gain total control of your money
      public static let title = Strings.tr("Localizable", "onboarding.second.title", fallback: "Gain total control of your money")
    }
    public enum Third {
      /// Setup your budget for each category so you in control. Track categories you spend the most money on
      public static let description = Strings.tr("Localizable", "onboarding.third.description", fallback: "Setup your budget for each category so you in control. Track categories you spend the most money on")
      /// Plan ahead and manage your money better
      public static let title = Strings.tr("Localizable", "onboarding.third.title", fallback: "Plan ahead and manage your money better")
    }
  }
  public enum Profile {
    /// Профиль
    public static let systemTitle = Strings.tr("Localizable", "profile.systemTitle", fallback: "Профиль")
  }
  public enum TabBar {
    /// Категории
    public static let categories = Strings.tr("Localizable", "tabBar.categories", fallback: "Категории")
    /// Главная
    public static let home = Strings.tr("Localizable", "tabBar.home", fallback: "Главная")
    /// Профиль
    public static let profile = Strings.tr("Localizable", "tabBar.profile", fallback: "Профиль")
    /// Транзакции
    public static let transactions = Strings.tr("Localizable", "tabBar.transactions", fallback: "Транзакции")
    /// Кошельки
    public static let wallets = Strings.tr("Localizable", "tabBar.wallets", fallback: "Кошельки")
  }
  public enum Wallets {
    /// Кошельки
    public static let systemTitle = Strings.tr("Localizable", "wallets.systemTitle", fallback: "Кошельки")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
