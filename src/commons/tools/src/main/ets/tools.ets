export class Tools {
  static randomColor() {
    const randomColor = Math.floor(Math.random() * 16777215).toString(16); // 生成一个 24 位的十六进制颜色代码
    let hexColor = `#${randomColor.padStart(6, '0')}`;
    return hexColor
  }
}