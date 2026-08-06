package com.sulake.habbo.ui.widget.chatinput.styleselector
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.habbo.ui.widget.chatinput.RoomChatInputView;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ChatStyleGridView implements IComponentInterfaceQueue
   {
      private static const SCREEN_LEFT_BORDER:int = 92;
      
      private static const CHAT_BAR_POPUP_OFFSET:int = 55;
      
      private var _window:UnknownICoreWindowComponents6;
      
      private var UnknownVarFromChatStyleGridView_RoomChatInputView_1:RoomChatInputView;
      
      public function ChatStyleGridView(param1:RoomChatInputView)
      {
         super();
         UnknownVarFromChatStyleGridView_RoomChatInputView_1 = param1;
         var _loc2_:IAssetLibraryCollection = param1.widget.assets;
         var _loc3_:XmlAsset = _loc2_.getAssetByName("styleselector_menu_new_xml") as XmlAsset;
         _window = _loc3_ == null || _loc3_.content == null ? null : UnknownICoreWindowComponents6(param1.widget.windowManager.buildFromXML(_loc3_.content as XML));
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
         }
         _window = null;
         UnknownVarFromChatStyleGridView_RoomChatInputView_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
      
      public function get grid() : IItemGridWindow
      {
         if(_window == null)
         {
            return null;
         }
         return IItemGridWindow(_window.findChildByName("itemgrid"));
      }
      
      public function get fontSizeList() : IItemListWindow
      {
         if(_window == null)
         {
            return null;
         }
         return IItemListWindow(_window.findChildByName("font_size_list"));
      }
      
      public function get window() : UnknownICoreWindowComponents6
      {
         return _window;
      }
      
      public function alignToSelector(param1:IWindowController_1) : void
      {
         var _loc2_:int = 0;
         if(_window == null || param1 == null || _window.parent == null)
         {
            return;
         }
         var _loc4_:Rectangle = new Rectangle();
         param1.getGlobalRectangle(_loc4_);
         var _loc3_:IWindowController_1 = IWindowController_1(_window.parent);
         _loc3_.x = _loc4_.right - _window.width;
         _loc3_.y = _loc4_.bottom - _window.height;
         var _loc5_:Point = new Point();
         _loc3_.getGlobalPosition(_loc5_);
         if(_loc5_.x < 92)
         {
            _loc2_ = 92 - _loc5_.x;
            _loc3_.x += _loc2_;
         }
         _loc3_.x = _loc4_.x;
         _loc3_.y = _loc4_.bottom - 55 - _window.height;
      }
   }
}

