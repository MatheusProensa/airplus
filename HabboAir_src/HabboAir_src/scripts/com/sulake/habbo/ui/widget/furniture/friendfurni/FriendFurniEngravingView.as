package com.sulake.habbo.ui.widget.furniture.friendfurni
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDisplayObjectWrapperController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.errors.IllegalOperationError;
   import flash.geom.Point;
   
   public class FriendFurniEngravingView implements UnknownIHabboAvatar1, IComponentInterfaceQueue
   {
      private var _stuffData:StringArrayStuffData;
      
      private var _widget:FriendFurniEngravingWidget;
      
      private var _window:IWindowController_1 = null;
      
      private var _disposed:Boolean = false;
      
      public function FriendFurniEngravingView(param1:FriendFurniEngravingWidget, param2:StringArrayStuffData)
      {
         super();
         _widget = param1;
         _stuffData = param2;
      }
      
      private static function setElementImage(param1:IWindowModel, param2:BitmapData, param3:int = 0, param4:int = 0, param5:int = 0) : void
      {
         var _loc9_:IBitmapWrapperController = null;
         var _loc6_:IDisplayObjectWrapperController = null;
         if(param2 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(param1.disposed)
         {
            return;
         }
         var _loc10_:int = param3 > 0 ? param3 : param1.height;
         var _loc7_:int = (param1.width - param2.width) / 2 + param4;
         var _loc8_:int = (_loc10_ - param2.height) / 2 + param5;
         if(param1 as IBitmapWrapperController != null)
         {
            _loc9_ = IBitmapWrapperController(param1);
            if(_loc9_.bitmap == null || param3 > 0)
            {
               _loc9_.bitmap = new BitmapData(param1.width,_loc10_,true,0);
            }
            _loc9_.bitmap.fillRect(_loc9_.bitmap.rect,0);
            _loc9_.bitmap.copyPixels(param2,param2.rect,new Point(_loc7_,_loc8_),null,null,false);
            param1.invalidate();
         }
         else if(param1 as IDisplayObjectWrapperController != null)
         {
            _loc6_ = IDisplayObjectWrapperController(param1);
            _loc6_.setDisplayObject(new Bitmap(param2));
         }
      }
      
      protected function get stuffData() : StringArrayStuffData
      {
         return _stuffData;
      }
      
      protected function get widget() : FriendFurniEngravingWidget
      {
         return _widget;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            destroyWindow();
            _widget = null;
            _stuffData = null;
            _disposed = true;
         }
      }
      
      public function open() : void
      {
         createWindow();
      }
      
      public function close() : void
      {
         destroyWindow();
      }
      
      protected function assetName() : String
      {
         throw new IllegalOperationError("Must implement in concrete view!");
      }
      
      private function createWindow() : void
      {
         var _loc2_:IAvatarImage_2 = null;
         var _loc1_:IAvatarImage_2 = null;
         if(!_window)
         {
            _window = IWindowController_1(widget.windowManager.buildFromXML(XML(widget.assets.getAssetByName(assetName()).content)));
            _window.procedure = windowProc;
            _window.center();
            _window.findChildByName("name_left").caption = stuffData.getValue(1);
            _window.findChildByName("name_right").caption = stuffData.getValue(2);
            _window.findChildByName("date").caption = stuffData.getValue(5);
            _loc2_ = widget.engravingWidgetHandler.container.avatarRenderManager.createAvatarImage(stuffData.getValue(3),"h",null,this);
            _loc1_ = widget.engravingWidgetHandler.container.avatarRenderManager.createAvatarImage(stuffData.getValue(4),"h",null,this);
            if(!_loc2_.isPlaceholder())
            {
               setAvatarImage("avatar_left",_loc2_.getCroppedImage("full"));
            }
            if(!_loc1_.isPlaceholder())
            {
               _loc1_.setDirection("full",4);
               setAvatarImage("avatar_right",_loc1_.getCroppedImage("full"));
            }
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc3_:IAvatarImage_2 = null;
         var _loc2_:IAvatarImage_2 = null;
         if(param1 == stuffData.getValue(3))
         {
            _loc3_ = widget.engravingWidgetHandler.container.avatarRenderManager.createAvatarImage(stuffData.getValue(3),"h",null,this);
            setAvatarImage("avatar_left",_loc3_.getCroppedImage("full"));
         }
         if(param1 == stuffData.getValue(4))
         {
            _loc2_ = widget.engravingWidgetHandler.container.avatarRenderManager.createAvatarImage(stuffData.getValue(4),"h",null,this);
            _loc2_.setDirection("full",4);
            setAvatarImage("avatar_right",_loc2_.getCroppedImage("full"));
         }
      }
      
      private function setAvatarImage(param1:String, param2:BitmapData) : void
      {
         var _loc3_:IBitmapWrapperController = IBitmapWrapperController(_window.findChildByName(param1));
         setElementImage(_loc3_,param2,0,0,0);
      }
      
      private function destroyWindow() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function windowProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var _loc3_:* = param2.name;
            if("header_button_close" === _loc3_)
            {
               widget.close(widget.stuffId);
            }
         }
      }
   }
}

