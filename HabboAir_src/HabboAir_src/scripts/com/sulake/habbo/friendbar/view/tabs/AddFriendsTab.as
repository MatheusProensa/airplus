package com.sulake.habbo.friendbar.view.tabs
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.motion.Combo;
   import com.sulake.core.window.motion.EaseOut;
   import com.sulake.core.window.motion.Motions;
   import com.sulake.core.window.motion.MoveBy;
   import com.sulake.core.window.motion.ResizeTo;
   import flash.display.BitmapData;
   
   public class AddFriendsTab extends Tab
   {
      protected static const ICON:String = "icon";
      
      protected static const UnknownConstFromAddFriendsTab_String_1:String = "text";
      
      protected static const HEADER:String = "header";
      
      protected static const LABEL:String = "label";
      
      protected static const UnknownConstFromAddFriendsTab_String_2:String = "button";
      
      private static const UnknownConstFromAddFriendsTab_String_3:String = "add_friends_tab_xml";
      
      private static const ICON_RESOURCE:String = "find_friends_icon_png";
      
      private static var UnknownVarFromAddFriendsTab_Int_1:int = -1;
      
      private static const DEFAULT_COLOR:uint = 8374494;
      
      private static const UnknownConstFromAddFriendsTab_Uint_1:uint = 9560569;
      
      private static const UnknownConstFromAddFriendsTab_Array_1:Array = [];
      
      private static const UnknownConstFromAddFriendsTab_Array_2:Array = [];
      
      public function AddFriendsTab()
      {
         super();
      }
      
      public static function allocate() : AddFriendsTab
      {
         var _loc1_:AddFriendsTab = UnknownConstFromAddFriendsTab_Array_1.length > 0 ? UnknownConstFromAddFriendsTab_Array_1.pop() : new AddFriendsTab();
         _loc1_._recycled = false;
         _loc1_._window = _loc1_.allocateEntityWindow();
         return _loc1_;
      }
      
      public function allocateEntityWindow() : IWindowController_1
      {
         var _loc1_:IWindowController_1 = UnknownConstFromAddFriendsTab_Array_2.length > 0 ? UnknownConstFromAddFriendsTab_Array_2.pop() : WINDOWING.buildFromXML(ASSETS.getAssetByName("add_friends_tab_xml").content as XML) as IWindowController_1;
         var _loc4_:IRegionWindow = IRegionWindow(_loc1_.findChildByName("header"));
         _loc1_.addEventListener("WME_CLICK",onMouseClick);
         _loc1_.addEventListener("WME_OVER",onMouseOver);
         _loc1_.addEventListener("WME_OUT",onMouseOut);
         _loc4_.addEventListener("WME_CLICK",onMouseClick);
         _loc4_.addEventListener("WME_OVER",onMouseOver);
         _loc4_.addEventListener("WME_OUT",onMouseOut);
         if(UnknownVarFromAddFriendsTab_Int_1 < 0)
         {
            UnknownVarFromAddFriendsTab_Int_1 = _loc1_.height;
         }
         _loc1_.height = HEIGHT;
         var _loc3_:IBitmapWrapperController = _loc1_.findChildByName("icon") as IBitmapWrapperController;
         _loc3_.disposesBitmap = false;
         if(ASSETS.getAssetByName("find_friends_icon_png") != null)
         {
            _loc3_.bitmap = ASSETS.getAssetByName("find_friends_icon_png").content as BitmapData;
         }
         var _loc2_:IWindowModel = _loc1_.findChildByName("button");
         _loc2_.addEventListener("WME_CLICK",onButtonClick);
         var _loc5_:IWindowModel = _loc1_.findChildByName("text");
         _loc5_.visible = false;
         return _loc1_;
      }
      
      private function releaseEntityWindow(param1:IWindowController_1) : void
      {
         var _loc2_:IRegionWindow = null;
         if(param1 && !param1.disposed)
         {
            param1.procedure = null;
            param1.removeEventListener("WME_CLICK",onMouseClick);
            param1.removeEventListener("WME_OVER",onMouseOver);
            param1.removeEventListener("WME_OUT",onMouseOut);
            _loc2_ = IRegionWindow(param1.findChildByName("header"));
            _loc2_.removeEventListener("WME_CLICK",onMouseClick);
            _loc2_.removeEventListener("WME_OVER",onMouseOver);
            _loc2_.removeEventListener("WME_OUT",onMouseOut);
            param1.findChildByName("button").removeEventListener("WME_CLICK",onButtonClick);
            param1.findChildByName("text").visible = false;
            param1.width = WIDTH;
            param1.height = HEIGHT;
            if(UnknownConstFromAddFriendsTab_Array_2.indexOf(param1) == -1)
            {
               UnknownConstFromAddFriendsTab_Array_2.push(param1);
            }
         }
      }
      
      override public function select(param1:Boolean) : void
      {
         if(!selected)
         {
            if(param1 && false && Motions.getMotionByTarget(_window) == null)
            {
               Motions.runMotion(new Combo(new EaseOut(new ResizeTo(_window,80,_window.width,UnknownVarFromAddFriendsTab_Int_1),3),new EaseOut(new MoveBy(_window,80,_window.x,-(UnknownVarFromAddFriendsTab_Int_1 - HEIGHT)),3)));
            }
            else
            {
               _window.height = UnknownVarFromAddFriendsTab_Int_1;
               _window.y = HEIGHT - _window.height;
            }
            _window.findChildByName("text").visible = true;
            super.select(param1);
         }
      }
      
      override public function deselect(param1:Boolean) : void
      {
         if(selected)
         {
            _window.findChildByName("text").visible = false;
            _window.height = HEIGHT;
            _window.y = 0;
            super.deselect(param1);
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
               UnknownConstFromAddFriendsTab_Array_1.push(this);
            }
         }
      }
      
      override protected function expose() : void
      {
         super.expose();
         ITextWindow(_window.findChildByTag("label")).underline = exposed;
         _window.color = exposed ? 9560569 : 8374494;
      }
      
      override protected function conceal() : void
      {
         super.conceal();
         ITextWindow(_window.findChildByTag("label")).underline = exposed;
         _window.color = exposed ? 9560569 : 8374494;
      }
      
      private function onButtonClick(param1:WindowMouseEvent) : void
      {
         if(!disposed && !recycled)
         {
            DATA.findNewFriends();
            deselect(true);
         }
      }
   }
}

