package com.sulake.habbo.ui.widget.messages
{
   import com.sulake.habbo.ui.widget.enums.AvatarExpressionEnum;
   
   public class RoomWidgetAvatarExpressionMessage extends RoomWidgetMessage
   {
      public static const UnknownConstFromRoomWidgetAvatarExpressionMessage_String_1:String = "RWCM_MESSAGE_AVATAR_EXPRESSION";
      
      private var _animation:AvatarExpressionEnum;
      
      public function RoomWidgetAvatarExpressionMessage(param1:AvatarExpressionEnum)
      {
         super("RWCM_MESSAGE_AVATAR_EXPRESSION");
         _animation = param1;
      }
      
      public function get animation() : AvatarExpressionEnum
      {
         return _animation;
      }
   }
}

