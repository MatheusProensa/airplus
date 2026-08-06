package com.sulake.habbo.catalog.collectibles
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.collectibles.renderer.model.BaseItemWrapper;
   import com.sulake.habbo.catalog.collectibles.util.CollectibleRarity;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.IProductImageWidget;
   
   public class CollectiblesRewardBoxView implements IComponentInterfaceQueue, IProfiler_1
   {
      public static var BG_STAR_ROTATE_SPEED:Number = 20;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromCollectiblesRewardBoxView_CollectiblesController_1:CollectiblesController;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromCollectiblesRewardBoxView_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromCollectiblesRewardBoxView_Array_1:Array = [];
      
      public function CollectiblesRewardBoxView(param1:CollectiblesController, param2:IHabboWindowManagerComponent)
      {
         super();
         UnknownVarFromCollectiblesRewardBoxView_CollectiblesController_1 = param1;
         _windowManager = param2;
         _window = param2.buildFromXML(XML(UnknownVarFromCollectiblesRewardBoxView_CollectiblesController_1.assets.getAssetByName("collectible_reward_xml").content),2) as IWindowController_1;
         UnknownVarFromCollectiblesRewardBoxView_IStaticBitmapWrapperWindow_1 = rotatingStar;
         UnknownVarFromCollectiblesRewardBoxView_CollectiblesController_1.registerUpdateReceiver(this,1);
         if(closeButton != null)
         {
            closeButton.addEventListener("WME_CLICK",onWindowCloseRequested);
         }
         if(okButton != null)
         {
            okButton.addEventListener("WME_CLICK",onWindowCloseRequested);
         }
      }
      
      public function dispose() : void
      {
         UnknownVarFromCollectiblesRewardBoxView_CollectiblesController_1.removeUpdateReceiver(this);
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      private function onWindowCloseRequested(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         showNextRewardOrClose();
      }
      
      private function hideWindow() : void
      {
         var _loc1_:IDesktopController = null;
         if(_windowManager != null && _window != null && _window.parent != null)
         {
            _loc1_ = _windowManager.getDesktop(2);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      public function showReward(param1:BaseItemWrapper, param2:Boolean) : void
      {
         var _loc3_:IDesktopController = null;
         if(param1.baseItem == null)
         {
            return;
         }
         UnknownVarFromCollectiblesRewardBoxView_Array_1.push(param1);
         if(_windowManager != null && _window != null && _window.parent == null)
         {
            _loc3_ = _windowManager.getDesktop(2);
            if(_loc3_ != null)
            {
               _loc3_.addChild(_window);
            }
            showNextRewardOrClose();
         }
         else if(param2)
         {
            showNextRewardOrClose();
         }
      }
      
      private function showNextRewardOrClose() : void
      {
         var _loc1_:BaseItemWrapper = null;
         if(UnknownVarFromCollectiblesRewardBoxView_Array_1.length > 0)
         {
            _loc1_ = UnknownVarFromCollectiblesRewardBoxView_Array_1.shift();
            populateRewardItem(_loc1_);
         }
         else
         {
            hideWindow();
         }
      }
      
      private function populateRewardItem(param1:BaseItemWrapper) : void
      {
         productImage.productInfo = param1;
         setWindowColors(param1.baseItem.rarity);
         productNameText.caption = UnknownVarFromCollectiblesRewardBoxView_CollectiblesController_1.getProductName(param1);
         rarityText.text = param1.baseItem.rarity.toUpperCase();
      }
      
      private function setWindowColors(param1:String) : void
      {
         var _loc2_:uint = CollectibleRarity.getRarityColor(param1);
         _window.color = _loc2_;
         background.color = _loc2_;
      }
      
      private function get background() : IWindowModel
      {
         return _window.findChildByName("background") as IWindowModel;
      }
      
      private function get productImage() : IProductImageWidget
      {
         var _loc1_:IWidgetWindowController = _window.findChildByName("product_image") as IWidgetWindowController;
         return _loc1_.widget as IProductImageWidget;
      }
      
      private function get productNameText() : ITextWindow
      {
         return _window.findChildByName("product_name") as ITextWindow;
      }
      
      private function get closeButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close") as IWindowModel;
      }
      
      private function get okButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("ok_button") as UnknownICoreWindowComponents4;
      }
      
      private function get rotatingStar() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("rotating_star") as IStaticBitmapWrapperWindow;
      }
      
      private function get rarityText() : ITextWindow
      {
         return _window.findChildByName("rarity_text") as ITextWindow;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Number = BG_STAR_ROTATE_SPEED * (param1 / 1000);
         UnknownVarFromCollectiblesRewardBoxView_IStaticBitmapWrapperWindow_1.rotation += _loc2_;
         UnknownVarFromCollectiblesRewardBoxView_IStaticBitmapWrapperWindow_1.rotation %= 360;
         UnknownVarFromCollectiblesRewardBoxView_IStaticBitmapWrapperWindow_1.invalidate();
      }
   }
}

