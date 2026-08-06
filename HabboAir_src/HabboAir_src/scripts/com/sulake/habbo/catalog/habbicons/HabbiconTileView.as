package com.sulake.habbo.catalog.habbicons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.habbicons.assets.HabbiconAssetManager;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   
   public class HabbiconTileView implements IComponentInterfaceQueue
   {
      private static const UnknownConstFromHabbiconTileView_Uint_1:uint = 12833703;
      
      private static const OWNED_BASE_HOVER:uint = 13492146;
      
      private static const OWNED_BASE_ACTIVE:uint = 13952185;
      
      private static const UnknownConstFromHabbiconTileView_Uint_2:uint = 10076534;
      
      private static const OWNED_OUTLINE_HOVER:uint = 12376223;
      
      private static const OWNED_OUTLINE_ACTIVE:uint = 13887677;
      
      private static const NOT_OWNED_BASE_IDLE:uint = 14735042;
      
      private static const NOT_OWNED_BASE_HOVER:uint = 15261385;
      
      private static const NOT_OWNED_BASE_ACTIVE:uint = 15458251;
      
      private static const NOT_OWNED_OUTLINE_IDLE:uint = 13944493;
      
      private static const NOT_OWNED_OUTLINE_HOVER:uint = 15129800;
      
      private static const NOT_OWNED_OUTLINE_ACTIVE:uint = 15392717;
      
      public static const UnknownConstFromHabbiconTileView_Vector_1:Vector.<HabbiconTileView> = new Vector.<HabbiconTileView>(0);
      
      private static const UnknownConstFromHabbiconTileView_ColorTransform_1:ColorTransform = new ColorTransform(0.35,0.35,0.35,0.65,90,85,80,0);
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromHabbiconTileView_HabbiconController_1:HabbiconController;
      
      private var _item:HabbiconEntryModel;
      
      private var UnknownVarFromHabbiconTileView_Function_1:Function;
      
      private var UnknownVarFromHabbiconTileView_Boolean_1:Boolean;
      
      private var _active:Boolean;
      
      private var _disposed:Boolean;
      
      public function HabbiconTileView(param1:IWindowController_1)
      {
         super();
         _window = param1.clone() as IWindowController_1;
         _window.addEventListener("WME_CLICK",onClicked);
         _window.addEventListener("WME_OVER",onOver);
         _window.addEventListener("WME_OUT",onOut);
      }
      
      public static function claim(param1:IWindowController_1) : HabbiconTileView
      {
         var _loc2_:HabbiconTileView = null;
         if(UnknownConstFromHabbiconTileView_Vector_1.length > 0)
         {
            _loc2_ = UnknownConstFromHabbiconTileView_Vector_1.pop();
         }
         else
         {
            _loc2_ = new HabbiconTileView(param1);
         }
         return _loc2_;
      }
      
      public static function release(param1:HabbiconTileView) : void
      {
         param1.recycle();
         UnknownConstFromHabbiconTileView_Vector_1.push(param1);
      }
      
      public function initialize(param1:HabbiconController, param2:HabbiconEntryModel, param3:Function) : void
      {
         UnknownVarFromHabbiconTileView_HabbiconController_1 = param1;
         UnknownVarFromHabbiconTileView_Function_1 = param3;
         _window.visible = true;
         refresh(param2);
      }
      
      public function recycle() : void
      {
         if(_window.parent != null)
         {
            (_window.parent as IWindowController_1).removeChild(_window);
         }
         clearBitmap();
         UnknownVarFromHabbiconTileView_HabbiconController_1 = null;
         _item = null;
         UnknownVarFromHabbiconTileView_Function_1 = null;
         UnknownVarFromHabbiconTileView_Boolean_1 = false;
         _active = false;
         _window.visible = false;
         favoriteIcon.visible = false;
         claimableIcon.visible = false;
         lockedOverlay.visible = false;
         updateLook();
      }
      
      public function refresh(param1:HabbiconEntryModel) : void
      {
         _item = param1;
         var _loc2_:BitmapData = HabbiconAssetManager.getPreviewBitmap(param1.habbiconId,false);
         var _loc3_:BitmapData = _loc2_ != null ? _loc2_.clone() : new BitmapData(40,40,true,0);
         clearBitmap();
         if(!param1.owned && !param1.claimable)
         {
            _loc3_.colorTransform(_loc3_.rect,UnknownConstFromHabbiconTileView_ColorTransform_1);
         }
         bitmap.bitmap = _loc3_;
         bitmap.invalidate();
         favoriteIcon.visible = param1.owned && param1.favorite;
         claimableIcon.visible = param1.claimable && !param1.owned;
         lockedOverlay.visible = !param1.owned && !param1.claimable;
         updateLook();
      }
      
      public function setActive(param1:Boolean) : void
      {
         _active = param1;
         updateLook();
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function get item() : HabbiconEntryModel
      {
         return _item;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_window.parent != null)
         {
            (_window.parent as IWindowController_1).removeChild(_window);
         }
         _window.removeEventListener("WME_CLICK",onClicked);
         _window.removeEventListener("WME_OVER",onOver);
         _window.removeEventListener("WME_OUT",onOut);
         clearBitmap();
         _window.dispose();
         _window = null;
         UnknownVarFromHabbiconTileView_HabbiconController_1 = null;
         _item = null;
         UnknownVarFromHabbiconTileView_Function_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function clearBitmap() : void
      {
         if(bitmap.bitmap != null)
         {
            bitmap.bitmap.dispose();
            bitmap.bitmap = null;
         }
      }
      
      private function updateLook() : void
      {
         var _loc4_:uint = _item != null && _item.owned ? 12833703 : 14735042;
         var _loc6_:uint = _item != null && _item.owned ? 13492146 : 15261385;
         var _loc5_:uint = _item != null && _item.owned ? 13952185 : 15458251;
         var _loc3_:uint = _item != null && _item.owned ? 10076534 : 13944493;
         var _loc2_:uint = _item != null && _item.owned ? 12376223 : 15129800;
         var _loc1_:uint = _item != null && _item.owned ? 13887677 : 15392717;
         tileBackground.color = 4278190080 | (_active ? _loc5_ : (UnknownVarFromHabbiconTileView_Boolean_1 ? _loc6_ : _loc4_));
         tileBorder.color = 4278190080 | (_active ? _loc1_ : (UnknownVarFromHabbiconTileView_Boolean_1 ? _loc2_ : _loc3_));
      }
      
      private function onClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromHabbiconTileView_Function_1 != null)
         {
            UnknownVarFromHabbiconTileView_Function_1(this);
         }
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         UnknownVarFromHabbiconTileView_Boolean_1 = true;
         updateLook();
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         UnknownVarFromHabbiconTileView_Boolean_1 = false;
         updateLook();
      }
      
      private function get bitmap() : IBitmapWrapperController
      {
         return _window.findChildByName("bitmap") as IBitmapWrapperController;
      }
      
      private function get favoriteIcon() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("favorite_icon") as IStaticBitmapWrapperWindow;
      }
      
      private function get claimableIcon() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("claimable_icon") as IStaticBitmapWrapperWindow;
      }
      
      private function get lockedOverlay() : IWindowModel
      {
         return _window.findChildByName("locked_overlay");
      }
      
      private function get tileBackground() : IWindowModel
      {
         return _window.findChildByName("tile_background");
      }
      
      private function get tileBorder() : UnknownICoreWindowComponents6
      {
         return _window.findChildByName("tile_border") as UnknownICoreWindowComponents6;
      }
   }
}

