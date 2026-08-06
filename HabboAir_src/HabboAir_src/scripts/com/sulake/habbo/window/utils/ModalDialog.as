package com.sulake.habbo.window.utils
{
   import com.sulake.core.window.IWindowContext_3;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IDisplayObjectWrapperController;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class ModalDialog implements IModalDialog
   {
      private static const MODAL_DIALOG_LAYER:int = 3;
      
      private static var UnknownVarFromModalDialog_Stage_1:Stage = null;
      
      private static var _windowManager:HabboWindowManagerComponent;
      
      private static var _container:IWindowController_1;
      
      private static var UnknownVarFromModalDialog_Int_1:int;
      
      private static const COLOR_TRANSFORM:ColorTransform = new ColorTransform(0.25,0.25,0.25);
      
      private var _disposed:Boolean;
      
      private var _rootWindow:IWindowModel;
      
      private var _background:IBitmapWrapperController;
      
      public function ModalDialog(param1:HabboWindowManagerComponent, param2:XML)
      {
         super();
         initialiseStaticMembers(param1);
         _background = modalContext.create("","",21,0,1,new Rectangle(0,0,1,1),null,_container,0) as IBitmapWrapperController;
         _rootWindow = _windowManager.buildFromXML(param2,3);
         _container.addChild(_rootWindow);
         _rootWindow.center();
         _container.visible = true;
         refresh();
      }
      
      private static function initialiseStaticMembers(param1:HabboWindowManagerComponent) : void
      {
         if(UnknownVarFromModalDialog_Stage_1 == null)
         {
            _windowManager = param1;
            UnknownVarFromModalDialog_Stage_1 = _windowManager.context.displayObjectContainer.stage;
            _container = modalContext.create("","",4,0,0,new Rectangle(0,0,1,1),null,null,0) as IWindowController_1;
            UnknownVarFromModalDialog_Stage_1.addEventListener("resize",onResize);
            UnknownVarFromModalDialog_Stage_1.addEventListener("enterFrame",onEnterFrame);
         }
      }
      
      private static function get modalContext() : IWindowContext_3
      {
         return _windowManager.getWindowContext(3);
      }
      
      private static function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc2_:IDesktopController = null;
         var _loc9_:IWindowModel = null;
         var _loc3_:IWindowContext_3 = null;
         var _loc6_:IBitmapWrapperController = null;
         var _loc7_:IWindowModel = null;
         if(_container == null)
         {
            return;
         }
         var _loc8_:* = _container.numChildren == 0;
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc2_ = _windowManager.getWindowContext(_loc4_).getDesktopWindow();
            _loc2_.visible = _loc8_;
            if(_loc8_)
            {
               for each(_loc9_ in _loc2_.iterator)
               {
                  _loc9_.invalidate();
               }
            }
            _loc4_++;
         }
         if(_loc8_)
         {
            return;
         }
         var _loc5_:Rectangle = new Rectangle(0,0,Math.max(1,UnknownVarFromModalDialog_Stage_1.stageWidth),Math.max(1,UnknownVarFromModalDialog_Stage_1.stageHeight));
         _container.rectangle = _loc5_;
         _loc4_ = 0;
         while(_loc4_ < _container.numChildren)
         {
            _loc9_ = _container.getChildAt(_loc4_);
            if(_loc4_ % 2 == 0)
            {
               _loc9_.rectangle = _loc5_;
               IBitmapWrapperController(_loc9_).bitmap = null;
            }
            else
            {
               _loc9_.center();
            }
            _loc4_++;
         }
         var _loc1_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,false,0);
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc3_ = _windowManager.getWindowContext(_loc4_);
            if(_loc3_ != null)
            {
               try
               {
                  _loc1_.draw(IDisplayObjectWrapperController(_loc3_.getDesktopWindow()).getDisplayObject());
               }
               catch(e:SecurityError)
               {
                  Logger.log("[ModalDialog] security error while drawing modal dialog:" + e.message);
               }
            }
            _loc4_++;
         }
         _loc1_.colorTransform(_loc1_.rect,COLOR_TRANSFORM);
         _loc4_ = 0;
         while(_loc4_ < _container.numChildren)
         {
            _loc9_ = _container.getChildAt(_loc4_);
            if(_loc4_ % 2 == 0)
            {
               _loc6_ = _loc9_ as IBitmapWrapperController;
               if(_loc4_ >= 2)
               {
                  _loc6_.bitmap = _loc1_.clone();
                  _loc1_ = _loc6_.bitmap;
                  _loc7_ = _container.getChildAt(_loc4_ - 1);
                  _loc1_.draw(WindowController(_loc7_).getGraphicContext(true),new Matrix(1,0,0,1,_loc7_.x,_loc7_.y),COLOR_TRANSFORM);
               }
               else
               {
                  _loc6_.bitmap = _loc1_;
               }
            }
            _loc9_.visible = _loc4_ >= _container.numChildren - 2;
            _loc9_.invalidate();
            _loc4_++;
         }
      }
      
      private static function onResize(param1:Event) : void
      {
         if(_container == null || _container.numChildren <= 0)
         {
            return;
         }
         UnknownVarFromModalDialog_Int_1 = 2;
         _container.getChildAt(_container.numChildren - 1).center();
      }
      
      private static function onEnterFrame(param1:Event) : void
      {
         if(_container == null || _container.numChildren <= 0)
         {
            return;
         }
         if(UnknownVarFromModalDialog_Int_1 > 0)
         {
            UnknownVarFromModalDialog_Int_1--;
            if(UnknownVarFromModalDialog_Int_1 == 0)
            {
               refresh();
            }
         }
      }
      
      public function get rootWindow() : IWindowModel
      {
         return _rootWindow;
      }
      
      public function get background() : IBitmapWrapperController
      {
         return _background;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_background != null)
            {
               _background.dispose();
               _background = null;
            }
            if(_rootWindow != null)
            {
               _rootWindow.dispose();
               _rootWindow = null;
            }
            refresh();
            if(_container != null && _container.numChildren == 0)
            {
               _container.visible = false;
            }
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

