package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class OutfitView
   {
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromOutfitView_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromOutfitView_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var _gradient:IStaticBitmapWrapperWindow;
      
      private var _button:UnknownICoreWindowComponents4;
      
      private var _bgColor:int;
      
      private var UnknownVarFromOutfitView_Int_1:int;
      
      private var _gradientColor:int;
      
      private var UnknownVarFromOutfitView_Int_2:int;
      
      private var _active:Boolean;
      
      public function OutfitView(param1:IHabboWindowManagerComponent, param2:IAssetLibraryCollection, param3:Boolean)
      {
         super();
         _windowManager = param1;
         UnknownVarFromOutfitView_IAssetLibraryCollection_1 = param2;
         var _loc4_:XmlAsset = UnknownVarFromOutfitView_IAssetLibraryCollection_1.getAssetByName("Outfit") as XmlAsset;
         _window = IWindowController_1(_windowManager.buildFromXML(_loc4_.content as XML));
         if(_window != null)
         {
            UnknownVarFromOutfitView_IBitmapWrapperController_1 = _window.findChildByName("bitmap") as IBitmapWrapperController;
            _gradient = _window.findChildByName("outfit_gradient") as IStaticBitmapWrapperWindow;
            _gradient.visible = false;
            _button = _window.findChildByName("button") as UnknownICoreWindowComponents4;
            if(!param3)
            {
               _button.disable();
            }
         }
      }
      
      public function dispose() : void
      {
         _windowManager = null;
         UnknownVarFromOutfitView_IAssetLibraryCollection_1 = null;
         if(_window)
         {
            _window.dispose();
         }
         _window = null;
         if(UnknownVarFromOutfitView_IBitmapWrapperController_1)
         {
            UnknownVarFromOutfitView_IBitmapWrapperController_1.dispose();
         }
         UnknownVarFromOutfitView_IBitmapWrapperController_1 = null;
      }
      
      public function update(param1:BitmapData) : void
      {
         UnknownVarFromOutfitView_IBitmapWrapperController_1.bitmap = new BitmapData(UnknownVarFromOutfitView_IBitmapWrapperController_1.width,UnknownVarFromOutfitView_IBitmapWrapperController_1.height,true,16777215);
         var _loc2_:int = (UnknownVarFromOutfitView_IBitmapWrapperController_1.width - param1.width) / 2;
         var _loc3_:int = UnknownVarFromOutfitView_IBitmapWrapperController_1.height - param1.height;
         UnknownVarFromOutfitView_IBitmapWrapperController_1.bitmap.copyPixels(param1,param1.rect,new Point(_loc2_,_loc3_));
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindowModel = null) : void
      {
         if(param1.type != "WME_CLICK")
         {
            if(param1.type == "WME_OVER")
            {
               _window.color = 13421772;
            }
            else if(param1.type == "WME_OUT")
            {
               _window.color = 6710886;
            }
         }
      }
      
      private function updateBackgroundColors() : void
      {
         _button.color = _active ? UnknownVarFromOutfitView_Int_1 : _bgColor;
         if(_gradientColor == -1)
         {
            _gradient.visible = false;
         }
         else
         {
            _gradient.color = _active ? UnknownVarFromOutfitView_Int_2 : _gradientColor;
            _gradient.visible = true;
         }
      }
      
      public function setColors(param1:int, param2:int, param3:int, param4:int) : void
      {
         _bgColor = param1;
         UnknownVarFromOutfitView_Int_1 = param2;
         _gradientColor = param3;
         UnknownVarFromOutfitView_Int_2 = param4;
         updateBackgroundColors();
      }
      
      public function toggleActive(param1:Boolean) : void
      {
         _active = param1;
         updateBackgroundColors();
      }
   }
}

