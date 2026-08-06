package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.catalog.HabboCatalog;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class ProductGridItem implements IProductGridItem
   {
      public static const GRID_ITEM_BORDER:String = "bg";
      
      protected var _view:IWindowController_1;
      
      private var UnknownVarFromProductGridItem_IItemGrid_1:IItemGrid;
      
      protected var _icon:IBitmapWrapperController;
      
      protected var UnknownVarFromProductGridItem_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromProductGridItem_Object_1:Object;
      
      private var _catalog:HabboCatalog;
      
      public function ProductGridItem(param1:HabboCatalog)
      {
         _catalog = param1;
         super();
      }
      
      public function get view() : IWindowController_1
      {
         return _view;
      }
      
      public function set grid(param1:IItemGrid) : void
      {
         UnknownVarFromProductGridItem_IItemGrid_1 = param1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         UnknownVarFromProductGridItem_IItemGrid_1 = null;
         _icon = null;
         UnknownVarFromProductGridItem_IBitmapWrapperController_1 = null;
         _catalog = null;
         if(_view != null)
         {
            _view.dispose();
            _view = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      protected function get catalog() : HabboCatalog
      {
         return _catalog;
      }
      
      public function activate() : void
      {
         if(!_view)
         {
            return;
         }
         if(_view.findChildByTag("ITEM_HILIGHT"))
         {
            _view.findChildByTag("ITEM_HILIGHT").visible = true;
         }
         else
         {
            _view.getChildByName("bg").style = 0;
         }
      }
      
      public function deactivate() : void
      {
         if(!_view)
         {
            return;
         }
         if(_view.findChildByTag("ITEM_HILIGHT"))
         {
            _view.findChildByTag("ITEM_HILIGHT").visible = false;
         }
         else
         {
            _view.getChildByName("bg").style = 3;
         }
      }
      
      public function set view(param1:IWindowController_1) : void
      {
         if(!param1)
         {
            return;
         }
         _view = param1;
         _view.procedure = eventProc;
         UnknownVarFromProductGridItem_IBitmapWrapperController_1 = _view.findChildByName("image_wide") as IBitmapWrapperController;
         if(UnknownVarFromProductGridItem_IBitmapWrapperController_1)
         {
            _view.findChildByName("wide_container").visible = useWideView;
            _view.findChildByName("small_container").visible = !useWideView;
            _view.width = useWideView ? _view.limits.maxWidth : int(_view.limits.minWidth);
         }
         else
         {
            UnknownVarFromProductGridItem_IBitmapWrapperController_1 = _icon;
         }
         _icon = _view.findChildByName("image") as IBitmapWrapperController;
         if(_view.findChildByTag("ITEM_HILIGHT"))
         {
            _view.findChildByTag("ITEM_HILIGHT").visible = false;
         }
         var _loc2_:IWindowModel = _view.findChildByName("multiContainer");
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
      }
      
      protected function get useWideView() : Boolean
      {
         return false;
      }
      
      public function setDraggable(param1:Boolean) : void
      {
         if(_view as IInteractiveWindow && param1)
         {
            (_view as IInteractiveWindow).setMouseCursorForState(4,5);
            (_view as IInteractiveWindow).setMouseCursorForState(4 | 1,5);
         }
      }
      
      private function eventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:Boolean = false;
         if(param1.type == "WME_UP")
         {
            UnknownVarFromProductGridItem_Object_1 = null;
         }
         else if(param1.type == "WME_DOWN")
         {
            if(param2 == null)
            {
               return;
            }
            UnknownVarFromProductGridItem_IItemGrid_1.select(this,true);
            UnknownVarFromProductGridItem_Object_1 = param2;
         }
         else if(param1.type == "WME_OUT" && UnknownVarFromProductGridItem_Object_1 != null && UnknownVarFromProductGridItem_Object_1 == param2)
         {
            _loc3_ = UnknownVarFromProductGridItem_IItemGrid_1.startDragAndDrop(this);
            if(_loc3_)
            {
               UnknownVarFromProductGridItem_Object_1 = null;
            }
         }
         else if(param1.type == "WME_UP")
         {
            UnknownVarFromProductGridItem_Object_1 = null;
         }
         else if(param1.type == "WME_CLICK")
         {
            UnknownVarFromProductGridItem_Object_1 = null;
         }
         else if(param1.type == "WME_DOUBLE_CLICK")
         {
            UnknownVarFromProductGridItem_Object_1 = null;
         }
      }
      
      public function setIconImage(param1:BitmapData, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:IBitmapWrapperController = targetIcon;
         if(_loc5_ != null && !_loc5_.disposed)
         {
            _loc3_ = (_loc5_.width - param1.width) / 2;
            _loc4_ = (_loc5_.height - param1.height) / 2;
            if(_loc5_.bitmap == null)
            {
               _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,16777215);
            }
            else
            {
               _loc5_.bitmap.fillRect(_loc5_.bitmap.rect,16777215);
            }
            _loc5_.bitmap.copyPixels(param1,param1.rect,new Point(_loc3_,_loc4_),null,null,false);
            _loc5_.invalidate();
         }
         if(param2)
         {
            param1.dispose();
         }
      }
      
      protected function get targetIcon() : IBitmapWrapperController
      {
         return useWideView ? UnknownVarFromProductGridItem_IBitmapWrapperController_1 : _icon;
      }
      
      protected function renderAvatarImage(param1:String, param2:UnknownIHabboAvatar1) : BitmapData
      {
         var _loc4_:IAvatarImage_2 = _catalog.avatarRenderManager.createAvatarImage(param1,"h",null,param2);
         var _loc3_:BitmapData = _loc4_.getCroppedImage("head",0.5);
         _loc4_.dispose();
         return _loc3_;
      }
   }
}

