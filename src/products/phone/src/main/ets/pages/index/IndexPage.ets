import { AxiosResponse } from '@ohos/axios';
// TODO: 动态库hsp在预览中有问题 按照提示设置mock后还是不行
// import { Api } from 'api_library'
// TODO: 静态库可以预览
import { Api } from 'api_library_static';

// TODO: why? 为何@Styles不可跨包？
// import { card } from 'ui_library'
// TODO: 不仅不能跨包 还不能跨文件
// import { card } from '../common/styles'
// TODO: 是的 太拉胯：https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-user-defined-extension-attributemodifier-V5
import { cardModifier, Colors } from '../../common/styles';
import { CardModifierFromLibrary } from 'ui_library';
import { Placeholder } from '../../common/component/placeholder';
import { Callback } from '@ohos.base';

export enum IndexPageEntryType {
  /**
   * 会员订房
   */
  Hydf,
  /**
   * 美食团购
   */
  Mstg,
  /**
   * 婚宴预定
   */
  Hyyd,
  /**
   * 我的订单
   */
  wddd,
  /**
   * 联系我们
   */
  lxwm,
  /**
   * 美食餐饮
   */
  mscj,
  /**
   * 集团酒店
   */
  jtjd,
  /**
   * 酒店位置
   */
  jdwz,
  /**
   * 客人说
   */
  krs
}

@Component
export struct IndexPage {
  // onTap?: Callback<IndexPageEntryType>
  private bottomItemList: Array<BottomItemData> = [
    new BottomItemData('美食餐饮', '', IndexPageEntryType.mscj),
    new BottomItemData('集团酒店', '', IndexPageEntryType.jtjd),
    new BottomItemData('酒店位置', '', IndexPageEntryType.jdwz),
    new BottomItemData('客人说', '', IndexPageEntryType.krs),
  ]
  layoutOptions: GridLayoutOptions = {
    regularSize: [1, 1],
    onGetRectByIndex: (index: number) => {
      if (index == 0) {
        return [0, 0, 4, 3]
      }
      if (index == 1) {
        return [0, 1, 4, 3]
      }
      if (index == 2) {
        return [1, 0, 3, 2]
      }
      if (index == 3) {
        return [1, 1, 3, 2]
      }
      if (index == 4) {
        return [1, 2, 3, 2]
      }
      return [5, 5, 0, 0]
    }
  }
  pageInfos: NavPathStack = new NavPathStack()

  onTap(data: IndexPageEntryType) {
    // TODO: 根据不同的点击来源做跳转
    if (data === IndexPageEntryType.Hydf) {

      // TODO: 大尺寸时 Navigation如果不设置适配模式 百分百会有重复跳转的问题

      // TODO: 这个queryNavDestinationInfo只有在NavDestination内部才能查询到
      let queryNavInfo = this.queryNavDestinationInfo()
      // TODO: 寻找更优的办法
      console.log(`---> queryNavInfo:`,queryNavInfo)
      console.log(`---> JSON.stringify(this.pageInfos):`,JSON.stringify(this.pageInfos))
      let hotelListIndex = this.pageInfos.getIndexByName('HotelList')
      console.log(`---> hotelListIndex:`,hotelListIndex,hotelListIndex.length,typeof hotelListIndex)
      console.log(`---> this.pageInfos.size():`,this.pageInfos.size())
      let canJumpHotelList = (hotelListIndex.length === 0 || this.pageInfos.size() === 0) && hotelListIndex[0] !== this.pageInfos.size() -1
      console.log(`---> canJumpHotelList:`,canJumpHotelList)

      if (canJumpHotelList) {
        this.pageInfos.pushPathByName("HotelList", null)
      }
      // this.pageInfos.pushPathByName("HotelList", null)
    }
  }

  build() {
    Navigation(this.pageInfos) {
      List() {
        ListItem() {
          Placeholder()
        }
        .aspectRatio(1.2)
        .margin({ bottom: 8 })

        ListItem() {
          Grid(null, this.layoutOptions) {
            GridItem() {
              Image($r('app.media.index_tuangou'))// .attributeModifier(cardModifier)
                // .card()
                // .attributeModifier(cardModifierFromLibrary8)
                // .attributeModifier(cardModifierFromLibrary16)
                // .attributeModifier(new CardModifierFromLibrary(30))
                .attributeModifier(cardModifier)
            }.onClick(() => this.onTap && this.onTap(IndexPageEntryType.Hydf))

            GridItem() {
              Image($r('app.media.index_tuangou'))
                .attributeModifier(cardModifier)
            }.onClick(() => this.onTap?.(IndexPageEntryType.Mstg))

            GridItem() {
              Image($r('app.media.index_yuding'))
                .attributeModifier(cardModifier)
            }.onClick(() => this.onTap?.(IndexPageEntryType.Hyyd))

            GridItem() {
              Image($r('app.media.index_yuding'))
                .attributeModifier(cardModifier)
            }.onClick(() => this.onTap?.(IndexPageEntryType.wddd))

            GridItem() {
              Image($r('app.media.index_yuding'))
                .attributeModifier(cardModifier)
            }.onClick(() => this.onTap?.(IndexPageEntryType.lxwm))
          }
          // .backgroundColor(Color.Yellow)
          .aspectRatio(1.5)
          .rowsGap(8)
          .columnsGap(8)
          .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
          .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
        }
        .margin({ bottom: 8 })

        ListItem() {
          Row() {
            ForEach(this.bottomItemList, (data: BottomItemData) => {
              Column() {
                Placeholder()
                  .aspectRatio(1)
                  .height(60)
                Blank().height(8)
                Text(data.title)
                  .bottomItemTS()
              }
              .onClick((e) => this.onTap?.(data.dataType))
            })
          }
          // .height(60)
          .width('100%')
          .justifyContent(FlexAlign.SpaceAround)
          .padding({ top: 8, bottom: 8 })
        }
        .backgroundColor(Color.White)
        .attributeModifier(cardModifier)
      }
      .backgroundColor(Colors.pageBgColor)
      .padding({ left: 16, right: 16 })
      .height('100%')
      .width('100%')
    }
  }
}

@Extend(Text)
function bottomItemTS() {
  .fontSize(16)
  .fontWeight(FontWeight.Bold)
}

class BottomItemData {
  title: string
  img: string
  dataType: IndexPageEntryType

  constructor(title: string, img: string, dataType: IndexPageEntryType) {
    this.title = title
    this.img = img
    this.dataType = dataType
  }
}