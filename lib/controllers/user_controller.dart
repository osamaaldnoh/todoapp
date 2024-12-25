
import 'package:get/get.dart';
import 'package:todoapp/model/user_model.dart';
import '../data/local/tables/user_db.dart';


class UserController extends GetxController
{
  RxList<UserModel> _userList = RxList<UserModel>();
  RxList<UserModel> get userList  => RxList([..._userList]);

  @override
  void onInit() {
    refresh();
    super.onInit();
  }

  void refresh() 
  async
  {
    _userList.value = await UserDB().readAllUsers();
    print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL:${_userList.value.length}");
  }

  void addUser(UserModel user)
  async
  {
    await UserDB().createUser(user);
    refresh();
    // Get.back();
  }
  UserModel findByID({required int id})
  {
    return _userList.firstWhere((element) => element.id == id);
  }

  // dynamic getRandomColor()
  // {
  //   Random random = Random();
  //   int randomIndex = random.nextInt(colors.length);
  //   return colors[randomIndex];
  // }

  void updataUser(UserModel user)
  async
  {
    await UserDB().updata(user);
    refresh();
    Get.back();
  }

void deletUser(UserModel user)
  async
  {
    await UserDB().delete(user);
    refresh();
  }

 

  // Today
  String getToday()
  {
    DateTime today = DateTime.now();
    return today.toString().substring(0,10);
  }

  // Tomorrow
  String getTomorrow()
  {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    return tomorrow.toString().substring(0,10);
  }

    String getAfterTomorrow()
  {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 2));
    return tomorrow.toString().substring(0,10);
  }

   // Tomorrow
  List<String> last30Days()
  {
    DateTime today = DateTime.now();
    DateTime oneMonthAgo = today.subtract(const Duration(days: 30));
    List<String> dates = [];
    for(int i = 0; i < 30;i++)
    {
      DateTime date = oneMonthAgo.add(Duration(days: i));
      dates.add(date.toString().substring(0,10));
    }

    return dates;
  }

  bool getStatus(UserModel user)
  {
    bool? isCompleted;

    if(user.isVerified == 0)
    {
      isCompleted = false;
    }
    else
    {
      isCompleted = true;
    }
    return isCompleted;

  }
}