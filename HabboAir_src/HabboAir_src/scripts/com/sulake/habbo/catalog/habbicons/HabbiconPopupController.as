package com.sulake.habbo.catalog.habbicons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class HabbiconPopupController implements IComponentInterfaceQueue
   {
      private static const HABBICON_POPUP_HORIZONTAL_MARGIN:int = 4;
      
      private static const HABBICON_POPUP_VERTICAL_OFFSET:int = 2;
      
      private static const UnknownConstFromHabbiconPopupController_Uint_1:uint = 7995440;
      
      private var UnknownVarFromHabbiconPopupController_IWindowController_1_1:IWindowController_1;
      
      private var _popup:IWindowModel;
      
      private var UnknownVarFromHabbiconPopupController_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents6_1:UnknownICoreWindowComponents6;
      
      private var _popupTitle:ITextWindow;
      
      private var UnknownVarFromHabbiconPopupController_ITextWindow_1:ITextWindow;
      
      private var UnknownVarFromHabbiconPopupController_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_1:UnknownICoreWindowComponents4;
      
      private var UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents6_2:UnknownICoreWindowComponents6;
      
      private var UnknownVarFromHabbiconPopupController_ITextWindow_2:ITextWindow;
      
      private var UnknownVarFromHabbiconPopupController_IIconWindow_1:IIconWindow;
      
      private var UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_2:UnknownICoreWindowComponents4;
      
      private var _activeTile:HabbiconTileView;
      
      private var UnknownVarFromHabbiconPopupController_Function_1:Function;
      
      private var UnknownVarFromHabbiconPopupController_Function_2:Function;
      
      private var _onHide:Function;
      
      private var UnknownVarFromHabbiconPopupController_Function_3:Function;
      
      private var UnknownVarFromHabbiconPopupController_IHabboConfigurationManager_1:IHabboConfigurationManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var UnknownVarFromHabbiconPopupController_Stage_1:Stage;
      
      private var UnknownVarFromHabbiconPopupController_Boolean_1:Boolean;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromHabbiconPopupController_Int_1:int;
      
      public function HabbiconPopupController(param1:IWindowController_1, param2:Function, param3:Function, param4:Function, param5:Function, param6:IHabboConfigurationManager, param7:IHabboLocalizationManager)
      {
         super();
         UnknownVarFromHabbiconPopupController_Function_1 = param2;
         UnknownVarFromHabbiconPopupController_Function_2 = param3;
         _onHide = param4;
         UnknownVarFromHabbiconPopupController_Function_3 = param5;
         UnknownVarFromHabbiconPopupController_IHabboConfigurationManager_1 = param6;
         _localization = param7;
         UnknownVarFromHabbiconPopupController_IWindowController_1_1 = param1.findChildByName("habbicon_popup_layer") as IWindowController_1;
         _popup = param1.findChildByName("habbicon_item_popup");
         UnknownVarFromHabbiconPopupController_IItemListWindow_1 = param1.findChildByName("habbicon_popup_content_list") as IItemListWindow;
         UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents6_1 = param1.findChildByName("habbicon_popup_background") as UnknownICoreWindowComponents6;
         _popupTitle = param1.findChildByName("habbicon_popup_title") as ITextWindow;
         UnknownVarFromHabbiconPopupController_ITextWindow_1 = param1.findChildByName("habbicon_popup_description") as ITextWindow;
         UnknownVarFromHabbiconPopupController_IWindowController_1_2 = param1.findChildByName("habbicon_popup_action_row") as IWindowController_1;
         UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_1 = param1.findChildByName("habbicon_popup_action_button") as UnknownICoreWindowComponents4;
         UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents6_2 = param1.findChildByName("habbicon_popup_bottom_bar") as UnknownICoreWindowComponents6;
         UnknownVarFromHabbiconPopupController_ITextWindow_2 = param1.findChildByName("habbicon_popup_price") as ITextWindow;
         UnknownVarFromHabbiconPopupController_IIconWindow_1 = param1.findChildByName("habbicon_popup_currency_icon") as IIconWindow;
         UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_2 = param1.findChildByName("habbicon_popup_buy_button") as UnknownICoreWindowComponents4;
         if(UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_1)
         {
            UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_1.addEventListener("WME_CLICK",onPopupActionClicked);
         }
         if(UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_2)
         {
            UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_2.addEventListener("WME_CLICK",onPopupBuyClicked);
         }
         hide(false);
      }
      
      public function showForTile(param1:HabbiconTileView) : void
      {
         if(!param1 || !param1.item || !_popup || !UnknownVarFromHabbiconPopupController_IWindowController_1_1)
         {
            return;
         }
         _activeTile = param1;
         var _loc2_:String = HabbiconPopupMode.resolve(param1.item);
         configurePopup(param1.item,_loc2_);
         _popup.visible = true;
         arrangePopupLists();
         positionPopup(param1);
         _popup.invalidate();
         UnknownVarFromHabbiconPopupController_Int_1 = getTimer() + 75;
      }
      
      public function hide(param1:Boolean = true) : void
      {
         var _loc2_:Boolean = _popup != null && _popup.visible;
         if(_popup)
         {
            _popup.visible = false;
         }
         _activeTile = null;
         if(param1 && _loc2_ && _onHide != null)
         {
            _onHide();
         }
      }
      
      public function attachToDesktop(param1:IDesktopController) : void
      {
         if(UnknownVarFromHabbiconPopupController_Boolean_1 || !param1)
         {
            return;
         }
         var _loc2_:DisplayObject = param1.getDisplayObject();
         if(!_loc2_ || !_loc2_.stage)
         {
            return;
         }
         UnknownVarFromHabbiconPopupController_Stage_1 = _loc2_.stage;
         UnknownVarFromHabbiconPopupController_Stage_1.addEventListener("mouseDown",onStageMouseDown,false,0,true);
         UnknownVarFromHabbiconPopupController_Stage_1.addEventListener("mouseWheel",onStageMouseWheel,true,0,true);
         UnknownVarFromHabbiconPopupController_Boolean_1 = true;
      }
      
      public function detachFromStage() : void
      {
         if(UnknownVarFromHabbiconPopupController_Boolean_1 && UnknownVarFromHabbiconPopupController_Stage_1)
         {
            UnknownVarFromHabbiconPopupController_Stage_1.removeEventListener("mouseDown",onStageMouseDown);
            UnknownVarFromHabbiconPopupController_Stage_1.removeEventListener("mouseWheel",onStageMouseWheel,true);
         }
         UnknownVarFromHabbiconPopupController_Boolean_1 = false;
         UnknownVarFromHabbiconPopupController_Stage_1 = null;
      }
      
      public function get visible() : Boolean
      {
         return _popup != null && _popup.visible;
      }
      
      public function get activeTile() : HabbiconTileView
      {
         return _activeTile;
      }
      
      private function configurePopup(param1:HabbiconEntryModel, param2:String) : void
      {
         if(!_popup || !_popupTitle || !UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_1 || !UnknownVarFromHabbiconPopupController_IWindowController_1_2 || !UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents6_2 || !UnknownVarFromHabbiconPopupController_ITextWindow_1)
         {
            return;
         }
         _popupTitle.caption = param1 && param1.name && param1.name.length > 0 ? param1.name : "Habbicon";
         var _loc3_:Boolean = param2 == "purchase" || param2 == "info";
         var _loc4_:* = param2 == "purchase";
         var _loc5_:Boolean = !_loc4_ && param2 != "info";
         UnknownVarFromHabbiconPopupController_ITextWindow_1.visible = _loc3_;
         UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents6_2.visible = _loc4_;
         UnknownVarFromHabbiconPopupController_IWindowController_1_2.visible = _loc5_;
         if(_loc3_)
         {
            UnknownVarFromHabbiconPopupController_ITextWindow_1.caption = resolveDescription(param1,param2);
         }
         var _loc6_:String = "";
         switch(param2)
         {
            case "claim":
               _loc6_ = localize("habbicon_reward.claim","Claim");
               UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_1.color = 106753;
               break;
            case "remove_favorite":
               _loc6_ = localize("habbicon.favourite.remove","Remove from favourites");
               UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_1.color = 7995440;
               break;
            case "add_favorite":
               _loc6_ = localize("habbicon.favourite.add","Add to favourites");
               UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_1.color = 106753;
               break;
            default:
               if(UnknownVarFromHabbiconPopupController_ITextWindow_2)
               {
                  UnknownVarFromHabbiconPopupController_ITextWindow_2.caption = !!param1 ? formatPrice(param1.priceCredits,param1.priceActivityPoints) : "0";
               }
               if(UnknownVarFromHabbiconPopupController_IIconWindow_1 && param1 != null)
               {
                  UnknownVarFromHabbiconPopupController_IIconWindow_1.style = getPriceIconStyle(param1.priceCredits,param1.priceActivityPoints,param1.activityPointType);
                  UnknownVarFromHabbiconPopupController_IIconWindow_1.fitToSize();
               }
         }
         if(_loc5_)
         {
            UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_1.caption = _loc6_;
         }
      }
      
      private function arrangePopupLists() : void
      {
         if(UnknownVarFromHabbiconPopupController_IItemListWindow_1)
         {
            UnknownVarFromHabbiconPopupController_IItemListWindow_1.arrangeListItems();
         }
         var _loc1_:IItemListWindow = _popup as IItemListWindow;
         if(_loc1_)
         {
            _loc1_.arrangeListItems();
         }
      }
      
      private function positionPopup(param1:HabbiconTileView) : void
      {
         if(!param1 || !param1.window || !_popup || !UnknownVarFromHabbiconPopupController_IWindowController_1_1)
         {
            return;
         }
         var _loc6_:Rectangle = new Rectangle();
         param1.window.getGlobalRectangle(_loc6_);
         var _loc7_:Rectangle = new Rectangle();
         UnknownVarFromHabbiconPopupController_IWindowController_1_1.getGlobalRectangle(_loc7_);
         var _loc5_:int = _loc6_.x - _loc7_.x + (_loc6_.width - _popup.width) * 0.5;
         var _loc3_:int = Math.max(4,UnknownVarFromHabbiconPopupController_IWindowController_1_1.width - _popup.width - 4);
         _loc5_ = Math.max(4,Math.min(_loc3_,_loc5_));
         var _loc4_:int = _loc6_.y - _loc7_.y - _popup.height + 2;
         var _loc2_:int = Math.max(0,UnknownVarFromHabbiconPopupController_IWindowController_1_1.height - _popup.height);
         _loc4_ = Math.max(0,Math.min(_loc2_,_loc4_));
         _popup.x = _loc5_;
         _popup.y = _loc4_;
      }
      
      private function onPopupActionClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromHabbiconPopupController_Function_1 != null && _activeTile && _activeTile.item)
         {
            UnknownVarFromHabbiconPopupController_Function_1(_activeTile,HabbiconPopupMode.resolve(_activeTile.item));
         }
      }
      
      private function onPopupBuyClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromHabbiconPopupController_Function_2 != null && _activeTile && _activeTile.item)
         {
            UnknownVarFromHabbiconPopupController_Function_2(_activeTile);
         }
      }
      
      private function resolveDescription(param1:HabbiconEntryModel, param2:String) : String
      {
         if(param1 == null)
         {
            return localize("habbicon.popup.desc.not_owned","Not owned");
         }
         if(param2 == "purchase")
         {
            return localize("habbicon.popup.desc.not_owned","Not owned");
         }
         if(param2 == "info" && param1.isReward)
         {
            if(param1.owned || param1.favorite)
            {
               return localize("generic.owned","Owned");
            }
            if(param1.claimable)
            {
               return localize("habbicon_reward.claim","Claim");
            }
            return localize("habbicon.popup.desc.locked","Locked");
         }
         if(param1.owned || param1.favorite)
         {
            return localize("generic.owned","Owned");
         }
         return localize("habbicon.popup.desc.not_owned","Not owned");
      }
      
      private function onStageMouseDown(param1:MouseEvent) : void
      {
         if(!visible)
         {
            return;
         }
         if(getTimer() <= UnknownVarFromHabbiconPopupController_Int_1)
         {
            return;
         }
         var _loc2_:Point = new Point(param1.stageX,param1.stageY);
         if(isPointInsideWindow(_popup,_loc2_))
         {
            return;
         }
         if(UnknownVarFromHabbiconPopupController_Function_3 != null && UnknownVarFromHabbiconPopupController_Function_3(_loc2_))
         {
            return;
         }
         hide();
      }
      
      private function onStageMouseWheel(param1:MouseEvent) : void
      {
         if(visible)
         {
            hide();
         }
      }
      
      private function isPointInsideWindow(param1:IWindowModel, param2:Point) : Boolean
      {
         if(!param1 || !param2)
         {
            return false;
         }
         var _loc3_:Rectangle = new Rectangle();
         param1.getGlobalRectangle(_loc3_);
         return _loc3_.containsPoint(param2);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         hide(false);
         detachFromStage();
         if(UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_1)
         {
            UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_1.removeEventListener("WME_CLICK",onPopupActionClicked);
         }
         if(UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_2)
         {
            UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_2.removeEventListener("WME_CLICK",onPopupBuyClicked);
         }
         UnknownVarFromHabbiconPopupController_IWindowController_1_1 = null;
         _popup = null;
         UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents6_1 = null;
         UnknownVarFromHabbiconPopupController_IItemListWindow_1 = null;
         _popupTitle = null;
         UnknownVarFromHabbiconPopupController_ITextWindow_1 = null;
         UnknownVarFromHabbiconPopupController_IWindowController_1_2 = null;
         UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_1 = null;
         UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents6_2 = null;
         UnknownVarFromHabbiconPopupController_ITextWindow_2 = null;
         UnknownVarFromHabbiconPopupController_IIconWindow_1 = null;
         UnknownVarFromHabbiconPopupController_UnknownICoreWindowComponents4_2 = null;
         _activeTile = null;
         UnknownVarFromHabbiconPopupController_Function_1 = null;
         UnknownVarFromHabbiconPopupController_Function_2 = null;
         _onHide = null;
         UnknownVarFromHabbiconPopupController_Function_3 = null;
         UnknownVarFromHabbiconPopupController_IHabboConfigurationManager_1 = null;
         _localization = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function formatPrice(param1:int, param2:int) : String
      {
         if(param1 > 0 && param2 > 0)
         {
            return param1 + "c + " + param2;
         }
         if(param1 > 0)
         {
            return param1.toString();
         }
         return Math.max(0,param2).toString();
      }
      
      private function getPriceIconStyle(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = param2 > 0 ? param3 : 7;
         return ActivityPointTypeEnum.getIconStyleFor(_loc4_,UnknownVarFromHabbiconPopupController_IHabboConfigurationManager_1,false);
      }
      
      private function localize(param1:String, param2:String) : String
      {
         var _loc3_:String = _localization != null ? _localization.getLocalization(param1,param2) : param2;
         return _loc3_ != null && _loc3_.length > 0 ? _loc3_ : param2;
      }
   }
}

