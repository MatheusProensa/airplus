package com.sulake.habbo.ui.widget.messages
{
   import com.sulake.core.window.IWindowController_1;
   
   public class RoomWidgetAvatarEditorMessage extends RoomWidgetMessage
   {
      public static const UnknownConstFromRoomWidgetAvatarEditorMessage_String_1:String = "RWCM_OPEN_AVATAR_EDITOR";
      
      public static const WIDGET_MESSAGE_GET_WARDROBE:String = "RWCM_GET_WARDROBE";
      
      public static const UnknownConstFromRoomWidgetAvatarEditorMessage_String_2:String = "RWAEM_AVATAR_EDITOR_VIEW_DISPOSED";
      
      private var _context:IWindowController_1;
      
      public function RoomWidgetAvatarEditorMessage(param1:String, param2:IWindowController_1 = null)
      {
         super(param1);
         _context = param2;
      }
      
      public function get context() : IWindowController_1
      {
         return _context;
      }
   }
}

