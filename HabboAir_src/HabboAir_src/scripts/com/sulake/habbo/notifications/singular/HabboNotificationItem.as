package com.sulake.habbo.notifications.singular
{
   public class HabboNotificationItem
   {
      private var _style:HabboNotificationItemStyle;
      
      private var _content:String;
      
      private var UnknownVarFromHabboNotificationItem_SingularNotificationController_1:SingularNotificationController;
      
      public function HabboNotificationItem(param1:String, param2:HabboNotificationItemStyle, param3:SingularNotificationController)
      {
         super();
         _content = param1;
         _style = param2;
         UnknownVarFromHabboNotificationItem_SingularNotificationController_1 = param3;
      }
      
      public function get style() : HabboNotificationItemStyle
      {
         return _style;
      }
      
      public function get content() : String
      {
         return _content;
      }
      
      public function get notificationId() : String
      {
         if(_style == null || _style.extraData == null)
         {
            return null;
         }
         return _style.extraData["id"];
      }
      
      public function dispose() : void
      {
         _content = null;
         if(_style != null)
         {
            _style.dispose();
            _style = null;
         }
         UnknownVarFromHabboNotificationItem_SingularNotificationController_1 = null;
      }
      
      public function ExecuteUiLinks() : void
      {
         if(_style.internalLink)
         {
            UnknownVarFromHabboNotificationItem_SingularNotificationController_1.onInternalLink(_style.internalLink);
         }
      }
   }
}

