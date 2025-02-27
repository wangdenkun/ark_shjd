import { Colors } from '../common/styles'
import { IndexPage, IndexPageEntryType } from './index/IndexPage'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State currentIndex: number = 0
  private tabItemList: Array<TabBarItemData> = [
    new TabBarItemData($r('app.string.index_tab_bar_index'), 0, $r('sys.symbol.house_fill'), ''),
    new TabBarItemData($r('app.string.index_tab_bar_member'), 1, $r('sys.symbol.heart_square_stack_fill'), ''),
    new TabBarItemData($r('app.string.index_tab_bar_mine'), 2, $r('sys.symbol.person_fill'), ''),
  ]
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()

  @Builder
  tabBuilder(data: TabBarItemData) {
    Column() {
      if (this.currentIndex === data.index) {
        SymbolGlyph(data.selectedImg)
          .fontSize(24)
          .fontColor([Colors.primaryColor, Color.Blue])
          .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_COLOR) // 玩得真花 还能多色
      } else {
        SymbolGlyph(data.selectedImg)
          .fontSize(24)
      }
      Blank().height(8)
      Text(data.title)
        .fontColor(this.currentIndex === data.index ? Colors.primaryColor : Color.Gray)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: 8, bottom: 8 })
    .backgroundColor(Color.White)
  }

  // onTapIndex(data: IndexPageEntryType) {
  //   console.log(`---> indexPage onTapIndex data:`, data)
  //   console.log(`---> this:`,this)
  //   console.log(`---> this.pageInfos:`,this.pageInfos)
  //   // TODO: 根据不同的点击来源做跳转
  //   if (data === IndexPageEntryType.Hydf) {
  //     this.pageInfos.pushPathByName("HotelList", null)
  //   }
  // }

  aboutToAppear(): void {
    console.log(`---> this.pageInfos:`, this.pageInfos)
  }

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        // IndexPage({
        //   onTap: this.onTapIndex
        // })
        IndexPage()
      }.tabBar(this.tabBuilder(this.tabItemList[0]))

      TabContent() {
        Text('会员')
      }.tabBar(this.tabBuilder(this.tabItemList[1]))

      TabContent() {
        Text('我的')
      }.tabBar(this.tabBuilder(this.tabItemList[2]))
    }
    .onTabBarClick((index) => {
      this.currentIndex = index
    })
    .barHeight(80)
    .height('100%')
    .width('100%')
  }
}

class TabBarItemData {
  title: Resource
  index: number
  selectedImg: Resource
  normalImg: string

  constructor(title: Resource, index: number, selectedImg: Resource, normalImg: string) {
    this.title = title
    this.index = index
    this.selectedImg = selectedImg
    this.normalImg = normalImg
  }
}