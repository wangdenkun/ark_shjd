import { Api, AxiosError, AxiosResponse } from 'api_library_static';
import { promptAction } from '@kit.ArkUI';
import { Colors } from '../../common/styles';
import { Tools } from 'tools';
import { cardModifierFromLibrary8 } from 'ui_library';


@Builder
export function PageBuilder() {
  HotelListPage()
}

@Entry
@Preview
@Component
struct HotelListPage {
  @State message: string = 'Hello World';
  pageInfos: NavPathStack = new NavPathStack();
  @State hotelList: Array<Hotel> = []

  refreshData() {
    Api.getHotelList().then((res: AxiosResponse) => {
      console.log(`---> HotelListPage JSON.stringify(res.data):`, JSON.stringify(res.data))
      this.hotelList = res.data as Array<Hotel>
    }).catch((reason: AxiosError) => {
      console.log(`---> Api.getHotelList Error reason:`, reason)
      promptAction.showToast({
        message: reason.message,
        textColor: Color.Red
      })
    })

  }

  aboutToAppear(): void {
    this.refreshData()
  }

  build() {
    NavDestination() {
      List({ space: 32 }) {
        ForEach(this.hotelList, (data: Hotel) => {
          ListItem() {
            HotelCell({ hotel: data })
          }
          .padding({ left: 8, right: 8 })

          // .width('100%')
        }, (data: Hotel) => data.id)
      }
      .width('100%')
      .height('100%')
      .divider({
        strokeWidth: 2,
      })
      .backgroundColor(Colors.pageBgColor)
    }
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack
    })
    .onBackPressed(() => {
      this.pageInfos.pop()
      return true
    })
    .title('酒店列表')
  }
}


@Extend(Text)
function secondTS() {
  .fontSize(10)
  .fontColor(Color.Gray)
}

@Extend(Text)
function cellTitleTs() {
  .fontSize(16)
  .fontColor(Color.Black)
  .fontWeight(FontWeight.Bolder)
}

@Component
struct HotelCell {
  @Prop hotel: Hotel

  build() {
    // Row() {
    Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Stretch }) {
      Image(this.hotel.imageUrl)
        .aspectRatio(1.2)
        .layoutWeight(1)
        .attributeModifier(cardModifierFromLibrary8)
        .objectFit(ImageFit.Cover)
      Blank().width(16)
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Stretch }) {
        Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center }) {
          Text(this.hotel.name)
            .cellTitleTs()
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })// .flexGrow(1)
            // .backgroundColor(Color.Green)
            .flexGrow(1)
          Blank().width(8)
          Text('555km')
            .secondTS()
            .flexShrink(0) // https://developer.huawei.com/consumer/cn/forum/topic/0203144518225537833
            .maxLines(1)
        }
        // .backgroundColor(Color.Pink)

        Text(this.hotel.address)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)

        Blank()

        Row() {
          ForEach(this.hotel.labelList, (label: string) => {
            Text(label)
          })
          Blank()
          Text(this.hotel.price)
        }
        .justifyContent(FlexAlign.SpaceAround)
        // .backgroundColor(Color.Pink)
      }
      .layoutWeight(3)
      // .backgroundColor(Color.Red)
    }
    .width('100%')
    // .backgroundColor(Color.Yellow)
    .backgroundImageSize(ImageSize.Auto)
  }
}

class Hotel {
  id?: string
  name?: string
  totalReviewsNum?: string
  address?: string
  imageUrl?: string
  price?: string
  labelList?: string[]
}