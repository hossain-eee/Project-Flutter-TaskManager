
# module_12_class_3

token error handle for both get and post request in http request.

one more thing, each time user login token validation is 36 hours, after 36 hours user can't post anything with this token id. so I need to handle this by forcing the user to sign out and login again to get token validation for the next 36 hours.

SummaryCard() update from api server, get data from api like that number of task and type of task new/completed/.... and render it horizontally , and this data have to update automatic when this page is load, that's why called this method inside initState() and use  WidgetsBinding.instance.addPostFrameCallback() 

in SummaryCard() widget use  LinearProgressIndicator() to show horizontal progress bar when load from server

get token value form Post login and put this value inside Task Manager Variable token and each item of Task Manager like GET listTaskByStatus Headers token to access data to make pojo class(model class) of those items. And this model class is the same for new task, progress, canceled and complete because api provide same data for all of them just status value will change by api.


 For new_task_scren, take model class in task_list_tile.dart file as variable data type make it required constructor. use this model class object to access any data from Model class. When calling this task_list_tile.dart in any screen the required constructor value will take an index of model class data so that every time we use this task_list_tile.dart we will provide just an index.

use RefreshIndicator() Widget to pull down page for refresh the page for new task because only here added new things

# output

### summary Card() for count task
![curd_summary](https://github.com/hossain-eee/live-class-ostad/assets/101991583/f6fbf415-c6ea-47fc-92f7-859096c90bed)

### New Task, Progress Task, Canceled Task, Completed Task

![Screenshot_1690880672](https://github.com/hossain-eee/live-class-ostad/assets/101991583/fbb1b48e-9d3c-4ca6-96e1-403e78f0170d)
![Screenshot_1690880676](https://github.com/hossain-eee/live-class-ostad/assets/101991583/8cc3a86c-b18d-462e-a9f4-ade1489fb298)
![Screenshot_1690880683](https://github.com/hossain-eee/live-class-ostad/assets/101991583/228717aa-8432-4e1d-9655-357f820b4368)
![Screenshot_1690880686](https://github.com/hossain-eee/live-class-ostad/assets/101991583/3562e407-5df6-4ca2-9a61-2ec4874396dc)
![Screenshot_1690880692](https://github.com/hossain-eee/live-class-ostad/assets/101991583/64c535ff-b32e-418f-a9b5-1cfedc70fa09)
![Screenshot_1690880695](https://github.com/hossain-eee/live-class-ostad/assets/101991583/e925a310-3978-426e-a308-96ba14b04b1e)
![Screenshot_1690880697](https://github.com/hossain-eee/live-class-ostad/assets/101991583/2e442da9-f109-45f8-8d21-6aa1fdbf4855)
![Screenshot_1690880701](https://github.com/hossain-eee/live-class-ostad/assets/101991583/8dce68c7-3567-456a-82de-b43a9c93ea1d)
![Screenshot_1690880705](https://github.com/hossain-eee/live-class-ostad/assets/101991583/82777080-947a-4d18-a702-9888531b4d2d)


# given UI

![Artboard – 1](https://github.com/hossain-eee/live-class-ostad/assets/101991583/0a35aa23-c17f-42dd-bd9a-6adb74d65573)
