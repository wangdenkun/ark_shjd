import { Colors } from "../styles";

@Component
export struct Placeholder {
  build() {
    Image('https://www.huawei.com/-/media/corporate/images/home/logo/new-logo.png')
      .objectFit(ImageFit.Contain)
      .linearGradient({
        direction: GradientDirection.Right,
        repeating: false,
        colors: [[Colors.primaryColor, 0], [Colors.primaryColor, 1]]
      })
  }
}
