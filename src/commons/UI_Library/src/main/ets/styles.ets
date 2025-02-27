import { Tools } from 'tools'

// @Styles
// function card() {
//   .borderRadius(8)
// }

// @Styles
// function randomBackgroundColor() {
//   .backgroundColor(Tools.randomColor())
// }

class CardModifierFromLibrary implements AttributeModifier<CommonAttribute> {
  borderRadius: number = 8

  constructor(borderRadius?: number) {
    this.borderRadius = borderRadius ? borderRadius : 8
  }

  applyNormalAttribute(instance: CommonAttribute): void {
    instance.borderRadius(this.borderRadius)
  }
}

const cardModifierFromLibrary8 = new CardModifierFromLibrary(8)
const cardModifierFromLibrary16 = new CardModifierFromLibrary(16)

export {
  CardModifierFromLibrary, cardModifierFromLibrary8, cardModifierFromLibrary16
}