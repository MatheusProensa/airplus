package com.sulake.habbo.notifications.feed.view.pane
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.notifications.feed.NotificationView;
   import com.sulake.habbo.notifications.feed.view.content.IFeedEntity;
   
   public class NotificationsPane extends AbstractPane
   {
      private static const SECTIONS_LIST:String = "list";
      
      private static const UnknownConstFromNotificationsPane_String_1:String = "list_urgent";
      
      private static const UnknownConstFromNotificationsPane_String_2:String = "list_actions";
      
      private static const UnknownConstFromNotificationsPane_String_3:String = "list_persistent";
      
      private static const UnknownConstFromNotificationsPane_String_4:String = "list_notifications";
      
      private var UnknownVarFromNotificationsPane_IItemListWindow_1:IItemListWindow;
      
      public function NotificationsPane(param1:String, param2:NotificationView, param3:IWindowController_1)
      {
         super(param1,param2,param3,1);
         setUp();
      }
      
      override public function dispose() : void
      {
         UnknownVarFromNotificationsPane_IItemListWindow_1 = null;
         super.dispose();
      }
      
      private function setUp() : void
      {
         UnknownVarFromNotificationsPane_IItemListWindow_1 = _window.findChildByName("list") as IItemListWindow;
      }
      
      public function addItem(param1:int, param2:IFeedEntity) : void
      {
         var _loc3_:IItemListWindow = getSection(param1);
         _loc3_.addListItemAt(param2.window,0);
      }
      
      private function getSection(param1:int) : IItemListWindow
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case 0:
               _loc2_ = "list_urgent";
               break;
            case 1:
               _loc2_ = "list_actions";
               break;
            case 2:
               _loc2_ = "list_persistent";
               break;
            case 3:
               _loc2_ = "list_notifications";
         }
         return UnknownVarFromNotificationsPane_IItemListWindow_1.getListItemByName(_loc2_) as IItemListWindow;
      }
   }
}

