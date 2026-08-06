package com.sulake.habbo.catalog.special_items_display
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.special_items_display.model.IAbstractSpecialItem;
   import com.sulake.habbo.catalog.special_items_display.view.SpecialItemElementView;
   import com.sulake.habbo.catalog.special_items_display.view.SpecialItemPageButtonView;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.IProductIconWidget;
   
   public class SpecialItemsView implements IProfiler_1, IComponentInterfaceQueue
   {
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private static const BLEND_BUFFERING:Number = 0.1;
      
      public static const CLAIM_HEIGHT:int = 20;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromSpecialItemsView_SpecialItemsController_1:SpecialItemsController;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _window:IFrameController;
      
      private var _pageTemplate:IRegionWindow;
      
      private var _productDisplayTemplate:IWidgetWindowController;
      
      private var _pages:Vector.<SpecialItemPageButtonView> = new Vector.<SpecialItemPageButtonView>();
      
      private var UnknownVarFromSpecialItemsView_SpecialItemPageButtonView_1:SpecialItemPageButtonView;
      
      private var UnknownVarFromSpecialItemsView_Vector_1:Vector.<SpecialItemElementView> = new Vector.<SpecialItemElementView>();
      
      private var _latestDisplayKey:String = "";
      
      private var _visitedItems:Vector.<Boolean> = new Vector.<Boolean>();
      
      private var UnknownVarFromSpecialItemsView_Int_1:int = 0;
      
      private var UnknownVarFromSpecialItemsView_Int_2:int;
      
      private var UnknownVarFromSpecialItemsView_Boolean_1:Boolean;
      
      private var UnknownVarFromSpecialItemsView_Number_1:Number;
      
      private var UnknownVarFromSpecialItemsView_Number_2:Number;
      
      private var UnknownVarFromSpecialItemsView_Boolean_2:Boolean;
      
      private var _extraCycles:int = 0;
      
      private var UnknownVarFromSpecialItemsView_Int_3:int;
      
      private var UnknownVarFromSpecialItemsView_Number_3:Number = 1;
      
      private var UnknownVarFromSpecialItemsView_Number_4:Number = 1;
      
      public function SpecialItemsView(param1:SpecialItemsController, param2:IHabboWindowManagerComponent)
      {
         super();
         _windowManager = param2;
         UnknownVarFromSpecialItemsView_SpecialItemsController_1 = param1;
         _window = _windowManager.buildFromXML(XML(UnknownVarFromSpecialItemsView_SpecialItemsController_1.assets.getAssetByName("special_items_display_xml").content),1) as IFrameController;
         _pageTemplate = pageList.getListItemAt(0) as IRegionWindow;
         pageList.removeListItems();
         _productDisplayTemplate = itemRotation.removeChildAt(0) as IWidgetWindowController;
         closeButton.addEventListener("WME_CLICK",onClose);
         previousButton.addEventListener("WME_CLICK",onPreviousClick);
         nextButton.addEventListener("WME_CLICK",onNextClick);
         claimButton.addEventListener("WME_CLICK",onClaimClick);
         UnknownVarFromSpecialItemsView_SpecialItemsController_1.registerUpdateReceiver(this,1);
         hide();
      }
      
      private function get localizations() : IHabboLocalizationManager
      {
         return UnknownVarFromSpecialItemsView_SpecialItemsController_1.localizationManager;
      }
      
      public function displayNewData() : void
      {
         if(UnknownVarFromSpecialItemsView_SpecialItemsController_1.key != _latestDisplayKey)
         {
            _window.caption = localizations.getLocalizationWithParams("special_items.title","","set_name",localizations.getLocalization("special_items." + UnknownVarFromSpecialItemsView_SpecialItemsController_1.key + ".title"));
            setTitleText.text = localizations.getLocalization("special_items." + UnknownVarFromSpecialItemsView_SpecialItemsController_1.key + ".header.title");
            setDescText.text = localizations.getLocalization("special_items." + UnknownVarFromSpecialItemsView_SpecialItemsController_1.key + ".header.desc");
            initializePages();
            initializeElements();
            resetVisitedItems();
            resetToFirstElement();
         }
         _latestDisplayKey = UnknownVarFromSpecialItemsView_SpecialItemsController_1.key;
         _window.activate();
         updateClaimState();
      }
      
      public function updateClaimState() : void
      {
         var _loc1_:int = UnknownVarFromSpecialItemsView_SpecialItemsController_1.claimState;
         if(_loc1_ == 0)
         {
            claimSpacer.height = 0;
            claimContainer.visible = false;
         }
         else
         {
            claimSpacer.height = 20;
            claimContainer.visible = true;
            if(_loc1_ == 1 || _loc1_ == 2)
            {
               claimButton.disable();
               claimButton.caption = "${special_items.claim}";
            }
            else if(_loc1_ == 3)
            {
               claimButton.enable();
               claimButton.caption = "${special_items.claim}";
            }
            else if(_loc1_ == 4)
            {
               claimButton.disable();
               claimButton.caption = "${special_items.claimed}";
            }
         }
         reevaluateClaimableState();
      }
      
      private function resetVisitedItems() : void
      {
         UnknownVarFromSpecialItemsView_Int_1 = 0;
         _visitedItems = new Vector.<Boolean>(UnknownVarFromSpecialItemsView_SpecialItemsController_1.items.length,true);
      }
      
      private function clearPages() : void
      {
         pageList.removeListItems();
         for each(var _loc1_ in _pages)
         {
            _loc1_.dispose();
         }
         UnknownVarFromSpecialItemsView_SpecialItemPageButtonView_1 = null;
         _pages = new Vector.<SpecialItemPageButtonView>();
      }
      
      private function initializePages() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SpecialItemPageButtonView = null;
         clearPages();
         _loc2_ = 0;
         while(_loc2_ < totalElements)
         {
            _loc1_ = new SpecialItemPageButtonView(this,_loc2_);
            pageList.addListItem(_loc1_.window);
            _pages.push(_loc1_);
            _loc2_ += 1;
         }
         if(UnknownVarFromSpecialItemsView_SpecialItemsController_1.items.length == 0)
         {
            return;
         }
         UnknownVarFromSpecialItemsView_SpecialItemPageButtonView_1 = _pages[0];
         UnknownVarFromSpecialItemsView_SpecialItemPageButtonView_1.selected = true;
      }
      
      private function clearElements() : void
      {
         for each(var _loc1_ in UnknownVarFromSpecialItemsView_Vector_1)
         {
            itemRotation.removeChild(_loc1_.window);
            _loc1_.dispose();
         }
         UnknownVarFromSpecialItemsView_Vector_1 = new Vector.<SpecialItemElementView>();
      }
      
      private function initializeElements() : void
      {
         var _loc2_:SpecialItemElementView = null;
         clearElements();
         for each(var _loc1_ in UnknownVarFromSpecialItemsView_SpecialItemsController_1.items)
         {
            _loc2_ = new SpecialItemElementView(this,_loc1_);
            itemRotation.addChild(_loc2_.window);
            UnknownVarFromSpecialItemsView_Vector_1.push(_loc2_);
         }
      }
      
      public function resetToFirstElement() : void
      {
         if(UnknownVarFromSpecialItemsView_SpecialItemsController_1.items.length == 0)
         {
            return;
         }
         selectedPage = 0;
         var _loc1_:IAbstractSpecialItem = UnknownVarFromSpecialItemsView_SpecialItemsController_1.items[0];
         UnknownVarFromSpecialItemsView_Int_3 = -1;
         setItemPlaque(_loc1_);
         UnknownVarFromSpecialItemsView_Int_2 = 0;
         UnknownVarFromSpecialItemsView_Boolean_1 = false;
         UnknownVarFromSpecialItemsView_Number_1 = 0;
         UnknownVarFromSpecialItemsView_Number_2 = 0;
         UnknownVarFromSpecialItemsView_Boolean_2 = false;
         _extraCycles = 0;
         updateRotationAnimation();
         plaqueAndSpotlightBlend = 1;
         markItemVisited(UnknownVarFromSpecialItemsView_Int_2);
      }
      
      public function updateRotationAnimation() : void
      {
         for each(var _loc1_ in UnknownVarFromSpecialItemsView_Vector_1)
         {
            _loc1_.updateRotation(UnknownVarFromSpecialItemsView_Number_1);
         }
      }
      
      public function setItemPlaque(param1:IAbstractSpecialItem) : void
      {
         if(param1.index == UnknownVarFromSpecialItemsView_Int_3)
         {
            return;
         }
         UnknownVarFromSpecialItemsView_Int_3 = param1.index;
         itemTitleText.text = param1.name;
         itemDescText.text = param1.description;
         (productIconWidget.widget as IProductIconWidget).productInfo = param1;
      }
      
      public function get totalElements() : int
      {
         return UnknownVarFromSpecialItemsView_SpecialItemsController_1.items.length;
      }
      
      private function onNextClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:Boolean = UnknownVarFromSpecialItemsView_Boolean_1 && !UnknownVarFromSpecialItemsView_Boolean_2;
         navigateTo((UnknownVarFromSpecialItemsView_Int_2 + 1) % totalElements,true,false);
         _extraCycles = Math.max(0,_extraCycles);
         if(_loc2_ && (UnknownVarFromSpecialItemsView_Number_1 > UnknownVarFromSpecialItemsView_Int_2 - 1 && UnknownVarFromSpecialItemsView_Number_1 < UnknownVarFromSpecialItemsView_Int_2 || UnknownVarFromSpecialItemsView_Number_1 > totalElements - 1 && UnknownVarFromSpecialItemsView_Int_2 == 0))
         {
            _extraCycles += 1;
         }
      }
      
      private function onPreviousClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:Boolean = UnknownVarFromSpecialItemsView_Boolean_1 && UnknownVarFromSpecialItemsView_Boolean_2;
         navigateTo((UnknownVarFromSpecialItemsView_Int_2 - 1 + totalElements) % totalElements,true,true);
         _extraCycles = Math.min(0,_extraCycles);
         if(_loc2_ && (UnknownVarFromSpecialItemsView_Number_1 > UnknownVarFromSpecialItemsView_Int_2 && UnknownVarFromSpecialItemsView_Number_1 < UnknownVarFromSpecialItemsView_Int_2 + 1))
         {
            _extraCycles -= 1;
         }
      }
      
      public function navigateTo(param1:int, param2:Boolean = false, param3:Boolean = false) : void
      {
         UnknownVarFromSpecialItemsView_Int_2 = param1;
         selectedPage = param1;
         markItemVisited(param1);
         if(!param2)
         {
            _extraCycles = 0;
            param3 = false;
            if(UnknownVarFromSpecialItemsView_Number_1 > param1)
            {
               param3 = true;
            }
         }
         UnknownVarFromSpecialItemsView_Boolean_2 = param3;
         if(!UnknownVarFromSpecialItemsView_Boolean_1)
         {
            UnknownVarFromSpecialItemsView_Number_2 = 0;
            UnknownVarFromSpecialItemsView_Boolean_1 = true;
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc4_:Number = NaN;
         if(!UnknownVarFromSpecialItemsView_Boolean_1)
         {
            return;
         }
         var _loc2_:int = totalElements;
         var _loc5_:Number = 1000 / param1;
         var _loc7_:Number = UnknownVarFromSpecialItemsView_Int_2 - UnknownVarFromSpecialItemsView_Number_1;
         if(_loc7_ > 0 && UnknownVarFromSpecialItemsView_Boolean_2)
         {
            _loc7_ -= _loc2_;
         }
         else if(_loc7_ < 0 && !UnknownVarFromSpecialItemsView_Boolean_2)
         {
            _loc7_ += _loc2_;
         }
         if(!UnknownVarFromSpecialItemsView_Boolean_2 && _extraCycles > 0 || UnknownVarFromSpecialItemsView_Boolean_2 && _extraCycles < 0)
         {
            _loc7_ += _extraCycles * _loc2_;
         }
         var _loc3_:Number = Math.abs(_loc7_) * 2;
         var _loc6_:* = _loc3_ > UnknownVarFromSpecialItemsView_Number_2;
         if(_loc6_)
         {
            _loc3_ = UnknownVarFromSpecialItemsView_Number_2 * 0.95 + _loc3_ * 0.05;
         }
         else
         {
            _loc3_ = UnknownVarFromSpecialItemsView_Number_2 * 0.85 + _loc3_ * 0.15;
         }
         _loc3_ = Math.max(0.05,_loc3_);
         var _loc8_:Number = _loc3_ / _loc5_;
         if(UnknownVarFromSpecialItemsView_Boolean_2)
         {
            _loc8_ *= -1;
         }
         UnknownVarFromSpecialItemsView_Number_2 = _loc3_;
         if(!UnknownVarFromSpecialItemsView_Boolean_2 && _loc8_ > _loc7_ || UnknownVarFromSpecialItemsView_Boolean_2 && _loc8_ < _loc7_)
         {
            UnknownVarFromSpecialItemsView_Boolean_1 = false;
            UnknownVarFromSpecialItemsView_Number_1 = UnknownVarFromSpecialItemsView_Int_2;
            _extraCycles = 0;
         }
         else
         {
            UnknownVarFromSpecialItemsView_Number_1 += _loc8_;
            if(_extraCycles != 0)
            {
               _loc4_ = _loc7_ % _loc2_;
               if(_extraCycles > 0 && !UnknownVarFromSpecialItemsView_Boolean_2 && _loc8_ > _loc4_)
               {
                  _extraCycles -= 1;
               }
               else if(_extraCycles < 0 && UnknownVarFromSpecialItemsView_Boolean_2 && _loc8_ < _loc4_)
               {
                  _extraCycles += 1;
               }
            }
            if(UnknownVarFromSpecialItemsView_Number_1 > _loc2_)
            {
               UnknownVarFromSpecialItemsView_Number_1 -= _loc2_;
            }
            else if(UnknownVarFromSpecialItemsView_Number_1 < 0)
            {
               UnknownVarFromSpecialItemsView_Number_1 += _loc2_;
            }
         }
         updatePlaqueAndSpotlight();
         updateRotationAnimation();
      }
      
      private function updatePlaqueAndSpotlight() : void
      {
         var _loc3_:SpecialItemElementView = null;
         var _loc2_:Number = NaN;
         if(!UnknownVarFromSpecialItemsView_Boolean_1)
         {
            plaqueAndSpotlightBlend = 1;
            setItemPlaque(UnknownVarFromSpecialItemsView_Vector_1[UnknownVarFromSpecialItemsView_Int_2].item);
            return;
         }
         var _loc1_:* = 0;
         if(UnknownVarFromSpecialItemsView_Int_3 != -1)
         {
            _loc3_ = UnknownVarFromSpecialItemsView_Vector_1[UnknownVarFromSpecialItemsView_Int_3];
            _loc1_ = _loc3_.focusValue;
         }
         if(UnknownVarFromSpecialItemsView_Int_3 != UnknownVarFromSpecialItemsView_Int_2 && UnknownVarFromSpecialItemsView_Int_3 != -1 && _loc1_ == 0)
         {
            UnknownVarFromSpecialItemsView_Int_3 = -1;
         }
         if(UnknownVarFromSpecialItemsView_Int_3 != UnknownVarFromSpecialItemsView_Int_2 && _extraCycles == 0 && UnknownVarFromSpecialItemsView_Number_2 < Math.min(2,totalElements - 1))
         {
            _loc3_ = UnknownVarFromSpecialItemsView_Vector_1[UnknownVarFromSpecialItemsView_Int_2];
            _loc2_ = _loc3_.focusValue;
            if(_loc2_ > _loc1_)
            {
               _loc1_ = _loc2_;
               setItemPlaque(_loc3_.item);
            }
         }
         plaqueAndSpotlightBlend = _loc1_;
      }
      
      public function set plaqueAndSpotlightBlend(param1:Number) : void
      {
         var _loc3_:IScrollbarWindow = null;
         var _loc7_:IWindowModel = null;
         var _loc5_:IWindowModel = null;
         var _loc6_:Number = 0.4;
         if(param1 > 0.8)
         {
            _loc6_ = 0.4 + (param1 - 0.8) / 0.2 * 0.6;
         }
         var _loc2_:Boolean = Math.abs(UnknownVarFromSpecialItemsView_Number_4 - _loc6_) > 0.1 || _loc6_ == 0.4 && UnknownVarFromSpecialItemsView_Number_4 != 0.4 || _loc6_ == 1 && UnknownVarFromSpecialItemsView_Number_4 != 1;
         if(_loc2_)
         {
            spotlightBaseImg.blend = _loc6_;
            spotlightImg.blend = _loc6_;
         }
         var _loc4_:Boolean = Math.abs(UnknownVarFromSpecialItemsView_Number_3 - param1) > 0.1 || param1 == 0 && UnknownVarFromSpecialItemsView_Number_3 != 0 || param1 == 1 && UnknownVarFromSpecialItemsView_Number_3 != 1;
         if(_loc4_)
         {
            UnknownVarFromSpecialItemsView_Number_3 = param1;
            itemTitleText.blend = param1;
            itemDescText.blend = param1;
            (productIconWidget.widget as IProductIconWidget).blend = param1;
            _loc3_ = itemScrollArea.findChildByName("_SCROLLBAR") as IScrollbarWindow;
            _loc7_ = _loc3_.findChildByName("slider_track");
            _loc5_ = _loc7_.findChildByName("slider_bar");
            _loc7_.blend = param1;
            _loc5_.blend = param1;
         }
      }
      
      public function set selectedPage(param1:int) : void
      {
         if(UnknownVarFromSpecialItemsView_SpecialItemPageButtonView_1 != null)
         {
            UnknownVarFromSpecialItemsView_SpecialItemPageButtonView_1.selected = false;
            UnknownVarFromSpecialItemsView_SpecialItemPageButtonView_1 = null;
         }
         if(param1 >= 0 && param1 < _pages.length)
         {
            UnknownVarFromSpecialItemsView_SpecialItemPageButtonView_1 = _pages[param1];
            UnknownVarFromSpecialItemsView_SpecialItemPageButtonView_1.selected = true;
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      private function onClaimClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromSpecialItemsView_SpecialItemsController_1.claimState != 3)
         {
            return;
         }
         UnknownVarFromSpecialItemsView_SpecialItemsController_1.makeClaim();
      }
      
      public function hide() : void
      {
         var _loc1_:IDesktopController = null;
         if(isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      public function show() : void
      {
         var _loc1_:IDesktopController = null;
         if(!isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
               _window.center();
            }
         }
      }
      
      public function isShowing() : Boolean
      {
         return _window.parent != null;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         clearPages();
         UnknownVarFromSpecialItemsView_SpecialItemsController_1.removeUpdateReceiver(this);
         UnknownVarFromSpecialItemsView_Int_2 = 0;
         UnknownVarFromSpecialItemsView_Boolean_1 = false;
         UnknownVarFromSpecialItemsView_Number_1 = 0;
         UnknownVarFromSpecialItemsView_Number_2 = 0;
         UnknownVarFromSpecialItemsView_Boolean_2 = false;
         UnknownVarFromSpecialItemsView_Int_3 = 0;
         _window.dispose();
         _window = null;
         _pageTemplate.dispose();
         _pageTemplate = null;
         _productDisplayTemplate.dispose();
         _productDisplayTemplate = null;
         UnknownVarFromSpecialItemsView_SpecialItemsController_1 = null;
         _windowManager = null;
         _pages = null;
         _visitedItems = null;
         UnknownVarFromSpecialItemsView_Int_1 = 0;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get pageTemplate() : IRegionWindow
      {
         return _pageTemplate;
      }
      
      public function get productDisplayTemplate() : IWidgetWindowController
      {
         return _productDisplayTemplate;
      }
      
      private function markItemVisited(param1:int) : void
      {
         if(_visitedItems == null || param1 < 0 || param1 >= _visitedItems.length)
         {
            return;
         }
         if(_visitedItems[param1])
         {
            return;
         }
         _visitedItems[param1] = true;
         UnknownVarFromSpecialItemsView_Int_1 += 1;
         if(UnknownVarFromSpecialItemsView_Int_1 == _visitedItems.length)
         {
            reevaluateClaimableState();
         }
      }
      
      private function reevaluateClaimableState() : void
      {
         if(UnknownVarFromSpecialItemsView_SpecialItemsController_1.claimState != 2)
         {
            return;
         }
         if(_visitedItems == null || _visitedItems.length == 0)
         {
            return;
         }
         if(UnknownVarFromSpecialItemsView_Int_1 != _visitedItems.length)
         {
            return;
         }
         UnknownVarFromSpecialItemsView_SpecialItemsController_1.makeClaimable();
      }
      
      private function get closeButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get setTitleText() : ITextWindow
      {
         return _window.findChildByName("set_title") as ITextWindow;
      }
      
      private function get setDescText() : ITextWindow
      {
         return _window.findChildByName("set_desc") as ITextWindow;
      }
      
      private function get platformImg() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("platform_img") as IStaticBitmapWrapperWindow;
      }
      
      private function get spotlightImg() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("spotlight_img") as IStaticBitmapWrapperWindow;
      }
      
      private function get itemRotation() : IWindowController_1
      {
         return _window.findChildByName("item_rotation") as IWindowController_1;
      }
      
      private function get spotlightBaseImg() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("spotlight_base_img") as IStaticBitmapWrapperWindow;
      }
      
      private function get previousButton() : IRegionWindow
      {
         return _window.findChildByName("previous_button") as IRegionWindow;
      }
      
      private function get nextButton() : IRegionWindow
      {
         return _window.findChildByName("next_button") as IRegionWindow;
      }
      
      private function get pageList() : IItemListWindow
      {
         return _window.findChildByName("page_list") as IItemListWindow;
      }
      
      private function get claimContainer() : IWindowController_1
      {
         return _window.findChildByName("claim_container") as IWindowController_1;
      }
      
      private function get claimText() : ITextWindow
      {
         return _window.findChildByName("claim_txt") as ITextWindow;
      }
      
      private function get claimButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("claim_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get claimSpacer() : IWindowController_1
      {
         return _window.findChildByName("claim_spacer") as IWindowController_1;
      }
      
      private function get itemTitleText() : ITextWindow
      {
         return _window.findChildByName("item_title") as ITextWindow;
      }
      
      private function get itemDescText() : ITextWindow
      {
         return _window.findChildByName("item_desc") as ITextWindow;
      }
      
      private function get productIconWidget() : IWidgetWindowController
      {
         return _window.findChildByName("product_icon") as IWidgetWindowController;
      }
      
      private function get itemScrollArea() : IScrollableListWindow
      {
         return _window.findChildByName("item_scroll_area") as IScrollableListWindow;
      }
   }
}

