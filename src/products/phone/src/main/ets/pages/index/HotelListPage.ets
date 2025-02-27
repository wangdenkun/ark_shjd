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
            // Text(data.name)
            HotelCell({ hotel: data })
          }
          .padding({ left: 8, right: 8 })
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
    Row() {
      Image(this.hotel.imageUrl)
        .width('20%')
        .aspectRatio(1.2)
        .attributeModifier(cardModifierFromLibrary8)
        // .layoutWeight(1)
      Blank().width(16)
      Column() {
        Row() {
          Text(this.hotel.name)
            .cellTitleTs()
          Blank()
          Text('555km')
            .secondTS()
        }
        .backgroundColor(Color.Blue)
        // .justifyContent(FlexAlign.SpaceBetween)
        // .backgroundColor(Tools.randomColor())

        Text(this.hotel.address)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
        Row() {
          ForEach(this.hotel.labelList, (label: string) => {
            Text(label)
          })
          Blank()
          Text(this.hotel.price)
        }
        .justifyContent(FlexAlign.SpaceAround)
        .backgroundColor(Color.Pink)
      }
      .flexGrow(1)
      .backgroundColor(Color.Red)
      // .layoutWeight(3)
    }
    .width('100%')
    .backgroundColor(Color.Yellow)
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