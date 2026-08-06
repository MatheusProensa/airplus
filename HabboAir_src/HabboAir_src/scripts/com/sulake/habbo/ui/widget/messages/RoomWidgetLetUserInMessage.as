package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetLetUserInMessage extends RoomWidgetMessage
   {
      public static const LET_USER_IN:String = "RWLUIM_LET_USER_IN";
      
      private var _userName:String;
      
      private var _canEnter:Boolean;
      
      public function RoomWidgetLetUserInMessage(param1:String, param2:Boolean)
      {
         super("RWLUIM_LET_USER_IN");
         _userName = param1;
         _canEnter = param2;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get canEnter() : Boolean
      {
         return _canEnter;
      }
   }
}

