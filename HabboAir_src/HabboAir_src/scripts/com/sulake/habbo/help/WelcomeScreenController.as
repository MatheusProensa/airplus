package com.sulake.habbo.help
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class WelcomeScreenController implements IProfiler_1
   {
      private var _habboHelp:HabboHelp;
      
      private var _disposed:Boolean;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromWelcomeScreenController_Point_1:Point = new Point(72,10);
      
      private var UnknownVarFromWelcomeScreenController_String_1:String;
      
      private var UnknownVarFromWelcomeScreenController_Int_1:int;
      
      private var UnknownVarFromWelcomeScreenController_String_2:String;
      
      public function WelcomeScreenController(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(_habboHelp)
         {
            _habboHelp.removeUpdateReceiver(this);
            _habboHelp = null;
         }
         if(_window)
         {
            _window.findChildByName("close").removeEventListener("WME_CLICK",onCloseButton);
            _window.findChildByName("click").removeEventListener("WME_CLICK",onRegionClick);
            _window.dispose();
            _window = null;
         }
         _disposed = true;
      }
      
      public function showWelcomeScreen(param1:String, param2:String, param3:int, param4:String) : void
      {
         if(_disposed)
         {
            return;
         }
         UnknownVarFromWelcomeScreenController_String_1 = param1;
         UnknownVarFromWelcomeScreenController_Int_1 = param3;
         UnknownVarFromWelcomeScreenController_String_2 = param4;
         if(_window == null)
         {
            initializeWindow();
         }
         var _loc5_:ITextWindow = ITextWindow(_window.findChildByName("text"));
         _loc5_.caption = "${" + param2 + "}";
         _loc5_.height = _loc5_.textHeight + 5;
         updatePosition();
         this.registerUpdates();
         _window.visible = true;
         _window.activate();
      }
      
      private function initializeWindow() : void
      {
         var _loc1_:XmlAsset = _habboHelp.assets.getAssetByName("welcome_screen_xml") as XmlAsset;
         _window = _habboHelp.windowManager.buildFromXML(_loc1_.content as XML,2) as IWindowController_1;
         var _loc3_:IFrameController = _window.findChildByName("frame") as IFrameController;
         _loc3_.header.visible = false;
         _loc3_.content.y -= 20;
         var _loc2_:ITextWindow = _window.findChildByName("text") as ITextWindow;
         _loc2_.height = _loc2_.textHeight + 5;
         _loc3_.content.setParamFlag(2048,false);
         _loc3_.height -= 20;
         _window.findChildByName("close").addEventListener("WME_CLICK",onCloseButton);
         _window.findChildByName("click").addEventListener("WME_CLICK",onRegionClick);
      }
      
      private function updatePosition() : void
      {
         var _loc1_:Rectangle = _habboHelp.toolbar.getIconLocation(UnknownVarFromWelcomeScreenController_String_1);
         var _loc2_:IWindowModel = _window.findChildByName("arrow");
         var _loc3_:IWindowModel = _window.findChildByName("arrow_right");
         if(_loc1_ == null)
         {
            _loc1_ = new Rectangle(0,0,_window.width,_window.height);
         }
         if(UnknownVarFromWelcomeScreenController_Int_1 == 0)
         {
            UnknownVarFromWelcomeScreenController_Point_1.x = 72;
            _window.x = -_window.width;
            _loc2_.y = (_window.height - _loc2_.height) / 2;
            _loc2_.visible = true;
            _loc3_.visible = false;
         }
         else
         {
            UnknownVarFromWelcomeScreenController_Point_1.x = _loc1_.x - _window.width;
            _window.x = _loc1_.x + _loc1_.width + _window.width;
            _loc3_.y = (_window.height - _loc2_.height) / 2;
            _loc3_.visible = true;
            _loc2_.visible = false;
         }
         if(_loc1_ != null)
         {
            UnknownVarFromWelcomeScreenController_Point_1.y = _loc1_.y + _loc1_.height / 2 - _window.height / 2;
         }
         else
         {
            UnknownVarFromWelcomeScreenController_Point_1.y = 0;
         }
         _window.y = UnknownVarFromWelcomeScreenController_Point_1.y;
      }
      
      private function onCloseButton(param1:WindowMouseEvent) : void
      {
         closeWindow();
      }
      
      private function onRegionClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromWelcomeScreenController_String_2 != null)
         {
            _habboHelp.toolbar.toggleWindowVisibility(UnknownVarFromWelcomeScreenController_String_2);
         }
         closeWindow();
      }
      
      private function closeWindow() : void
      {
         if(!_window)
         {
            return;
         }
         _window.visible = false;
         dispose();
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:Point = null;
         if(_window == null)
         {
            _habboHelp.removeUpdateReceiver(this);
            return;
         }
         var _loc2_:Number = Point.distance(_window.position,UnknownVarFromWelcomeScreenController_Point_1);
         if(_loc2_ > 5)
         {
            _loc3_ = Point.interpolate(_window.position,UnknownVarFromWelcomeScreenController_Point_1,0.5);
            _window.x = _loc3_.x;
            _window.y = _loc3_.y;
         }
         else
         {
            _window.x = UnknownVarFromWelcomeScreenController_Point_1.x;
            _window.y = UnknownVarFromWelcomeScreenController_Point_1.y;
            _habboHelp.removeUpdateReceiver(this);
         }
      }
      
      private function registerUpdates() : void
      {
         _habboHelp.removeUpdateReceiver(this);
         _habboHelp.registerUpdateReceiver(this,10);
      }
      
      public function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         var _loc2_:Rectangle = null;
         if(_disposed)
         {
            return;
         }
         switch(param1.type)
         {
            case "HTE_RESIZED":
               if(_habboHelp != null)
               {
                  _loc2_ = _habboHelp.toolbar.getIconLocation(UnknownVarFromWelcomeScreenController_String_1);
               }
               if(_loc2_ != null)
               {
                  UnknownVarFromWelcomeScreenController_Point_1.y = _loc2_.y + _loc2_.height / 2 - _window.height / 2;
                  _window.y = UnknownVarFromWelcomeScreenController_Point_1.y;
               }
               break;
            case "HTE_TOOLBAR_CLICK":
            case "HTE_GROUP_ROOM_INFO_CLICK":
               closeWindow();
         }
      }
   }
}

