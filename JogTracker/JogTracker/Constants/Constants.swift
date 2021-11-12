import UIKit

struct Constants {
    struct CornerRadius {
        static let actionButton: CGFloat = 30
        static let actionButtonJogFormView: CGFloat = 26
        static let jogFormView: CGFloat = 29
    }
    struct Colors {
        struct AuthenticationScreen {
            static let actionButtonBorder = UIColor(red: 233/255, green: 144/255, blue: 249/255, alpha: 1)
            static let actionButtonText = UIColor(red: 233/255, green: 144/255, blue: 249/255, alpha: 1)
        }
        struct EmptyJogsScreen {
            static let actionButtonBorder = UIColor(red: 233/255, green: 144/255, blue: 249/255, alpha: 1)
            static let actionButtonText = UIColor(red: 233/255, green: 144/255, blue: 249/255, alpha: 1)
            static let centralLabel = UIColor(red: 165/255, green: 163/255, blue: 163/255, alpha: 1)
        }
        struct JogScreen {
            static let tableViewSeparator = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        }
        struct InfoScreen {
            static let titleLabel = UIColor(red: 126/255, green: 211/255, blue: 34/255, alpha: 1)
        }
    }
    struct BorderWidth {
        struct AuthenticationScreen {
            static let actionButton: CGFloat = 3
        }
        struct EmptyJogsScreen {
            static let actionButton: CGFloat = 3
        }
        struct JogForm {
            static let actionButton: CGFloat = 2
        }
    }
    struct Images {
        struct AuthenticationScreen {
            static let centralLogo = "authCentralLogo"
        }
        struct EmptyJogsScreen {
            static let centralLogo = "emptyJogsCentralLogo"
        }
        struct JogScreen {
            static let addNewJogButton = "addNewJog"
        }
    }
    struct Texts {
        struct InfoScreen {
            static let firstTextContainer = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
            static let secondTextContainer = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."
        }
    }
}
