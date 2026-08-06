package com.sulake.habbo.friendbar.view.tabs
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class NewOpenMessengerTab extends Tab
   {
      protected static const ICON:String = "icon";
      
      protected static const HEADER:String = "header";
      
      private static const UnknownConstFromNewOpenMessengerTab_String_1:String = "new_open_messenger_tab_xml";
      
      private static const DEFAULT_COLOR:uint = 8374494;
      
      private static const UnknownConstFromNewOpenMessengerTab_Uint_1:uint = 9560569;
      
      private static const FRIENDS_Y_PADDING:int = 10;
      
      private static const UnknownConstFromNewOpenMessengerTab_Array_1:Array = [];
      
      private static const UnknownConstFromNewOpenMessengerTab_Array_2:Array = [];
      
      public function NewOpenMessengerTab()
      {
         super();
      }
      
      public static function allocate() : NewOpenMessengerTab
      {
         var _loc1_:NewOpenMessengerTab = UnknownConstFromNewOpenMessengerTab_Array_1.length > 0 ? UnknownConstFromNewOpenMessengerTab_Array_1.pop() : new NewOpenMessengerTab();
         _loc1_._recycled = false;
         _loc1_._window = _loc1_.allocateEntityWindow();
         return _loc1_;
      }
      
      public function allocateEntityWindow() : IWindowController_1
      {
         var _loc1_:IWindowController_1 = UnknownConstFromNewOpenMessengerTab_Array_2.length > 0 ? UnknownConstFromNewOpenMessengerTab_Array_2.pop() : WINDOWING.buildFromXML(ASSETS.getAssetByName("new_open_messenger_tab_xml").content as XML) as IWindowController_1;
         _loc1_.addEventListener("WME_CLICK",onButtonClick);
         _loc1_.addEventListener("WME_OVER",onMouseOver);
         _loc1_.addEventListener("WME_OUT",onMouseOut);
         _loc1_.height = HEIGHT;
         return _loc1_;
      }
      
      private function releaseEntityWindow(param1:IWindowController_1) : void
      {
         if(param1 && !param1.disposed)
         {
            param1.procedure = null;
            param1.removeEventListener("WME_CLICK",onMouseClick);
            param1.removeEventListener("WME_OVER",onMouseOver);
            param1.removeEventListener("WME_OUT",onMouseOut);
            param1.width = WIDTH;
            param1.height = HEIGHT;
            if(UnknownConstFromNewOpenMessengerTab_Array_2.indexOf(param1) == -1)
            {
               UnknownConstFromNewOpenMessengerTab_Array_2.push(param1);
            }
         }
      }
      
      override public function recycle() : void
      {
         if(!disposed)
         {
            if(!_recycled)
            {
               if(_window)
               {
                  releaseEntityWindow(_window);
                  _window = null;
               }
               _recycled = true;
               UnknownConstFromNewOpenMessengerTab_Array_1.push(this);
            }
         }
      }
      
      override protected function expose() : void
      {
         super.expose();
         _window.color = exposed ? 9560569 : 8374494;
      }
      
      override protected function conceal() : void
      {
         super.conceal();
         _window.color = exposed ? 9560569 : 8374494;
      }
      
      private function onButtonClick(param1:WindowMouseEvent) : void
      {
         if(!disposed && !recycled)
         {
            DATA.toggleMessenger();
         }
      }
   }
}

