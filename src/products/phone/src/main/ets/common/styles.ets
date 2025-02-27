@Styles
function card() {
  .borderRadius(8)
}

class CardModifier implements AttributeModifier<CommonAttribute> {
  constructor() {
  }

  applyNormalAttribute(instance: CommonAttribute): void {
    instance.borderRadius(8)
  }
}

let cardModifier = new CardModifier()

class Colors {
  static primaryColor = '#DEA46B'
  static pageBgColor = '#F0F0F0'
}

export { cardModifier, Colors }