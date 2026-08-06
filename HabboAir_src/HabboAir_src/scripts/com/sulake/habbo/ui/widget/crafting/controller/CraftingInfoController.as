package com.sulake.habbo.ui.widget.crafting.controller
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import flash.display.BitmapData;
   
   public class CraftingInfoController implements UnknownIHabboRoom1
   {
      private static const DEBUG_PROGRESSBAR_TESTING_MODE:Boolean = false;
      
      private var UnknownVarFromCraftingInfoController_CraftingWidget_1:CraftingWidget;
      
      private var UnknownVarFromCraftingInfoController_CraftingProgressBarController_1:CraftingProgressBarController;
      
      public function CraftingInfoController(param1:CraftingWidget)
      {
         super();
         UnknownVarFromCraftingInfoController_CraftingWidget_1 = param1;
         UnknownVarFromCraftingInfoController_CraftingProgressBarController_1 = new CraftingProgressBarController(param1);
      }
      
      public function dispose() : void
      {
         UnknownVarFromCraftingInfoController_CraftingWidget_1 = null;
         if(UnknownVarFromCraftingInfoController_CraftingProgressBarController_1)
         {
            UnknownVarFromCraftingInfoController_CraftingProgressBarController_1.dispose();
            UnknownVarFromCraftingInfoController_CraftingProgressBarController_1 = null;
         }
      }
      
      public function setState(param1:int, ... rest) : void
      {
         var _loc9_:int = 0;
         var _loc6_:* = undefined;
         var _loc4_:* = null;
         var _loc7_:IFurnitureData = null;
         var _loc10_:ITextWindow = null;
         if(UnknownVarFromCraftingInfoController_CraftingWidget_1 == null || UnknownVarFromCraftingInfoController_CraftingWidget_1.handler == null || UnknownVarFromCraftingInfoController_CraftingWidget_1.handler.container == null)
         {
            return;
         }
         var _loc5_:String = "";
         var _loc8_:String = "";
         if(rest is Array && rest.length && rest[0] is Array)
         {
            _loc4_ = rest[0];
         }
         else
         {
            _loc4_ = rest;
         }
         var _loc3_:IHabboLocalizationManager = UnknownVarFromCraftingInfoController_CraftingWidget_1.handler.container.localization;
         switch(param1)
         {
            case 0:
               _loc5_ = "${crafting.info.start}";
               setButtonVisible(false);
               break;
            case 1:
               clearIcon();
               _loc5_ = "${crafting.info.mixer.empty}";
               disableButtonWith("${crafting.status.mixer.notavailable}");
               break;
            case 6:
               clearIcon();
               _loc5_ = "${crafting.info.product.empty}";
               setButtonVisible(false);
               break;
            case 3:
               clearIcon();
               _loc5_ = "${crafting.info.mixer.hit}";
               enableButton();
               break;
            case 4:
               clearIcon();
               _loc9_ = _loc4_[0] as int;
               _loc5_ = _loc3_.getLocalization("crafting.info.mixer.hit.plus.others","crafting.info.mixer.hit.plus.others");
               _loc5_ = _loc5_.replace("%number%",_loc9_);
               enableButton();
               break;
            case 5:
               clearIcon();
               _loc9_ = _loc4_[0] as int;
               _loc5_ = _loc3_.getLocalization("crafting.info.mixer.others");
               _loc5_ = _loc5_.replace("%number%",_loc9_);
               disableButtonWith("${crafting.status.mixer.notavailable}");
               break;
            case 2:
               clearIcon();
               _loc5_ = "${crafting.info.mixer.nohit}";
               disableButtonWith("${crafting.status.mixer.notavailable}");
               break;
            case 8:
               _loc7_ = _loc4_[0] as IFurnitureData;
               if(!_loc7_)
               {
                  return;
               }
               requestIconFromRoomEngine(_loc7_);
               _loc5_ = _loc3_.getLocalization("crafting.info.product.complete","crafting.info.product.complete");
               _loc8_ = _loc7_.localizedName;
               enableButton();
               break;
            case 7:
               _loc7_ = _loc4_[0] as IFurnitureData;
               if(!_loc7_)
               {
                  return;
               }
               requestIconFromRoomEngine(_loc7_);
               _loc6_ = _loc4_[1] as Vector.<String>;
               _loc5_ = _loc3_.getLocalization("crafting.info.product.incomplete","crafting.info.product.incomplete");
               _loc8_ = _loc7_.localizedName;
               disableButtonWith("${crafting.status.recipe.incomplete}");
               break;
            case 9:
               _loc7_ = _loc4_[0] as IFurnitureData;
               if(!_loc7_)
               {
                  return;
               }
               requestIconFromRoomEngine(_loc7_);
               _loc5_ = _loc3_.getLocalization("crafting.info.mixer.notininventory","crafting.info.mixer.notininventory");
               _loc5_ = _loc5_.replace("%product%",_loc7_.localizedName);
               break;
            case 999:
               _loc7_ = _loc4_[0] as IFurnitureData;
               if(!_loc7_)
               {
                  return;
               }
               requestIconFromRoomEngine(_loc7_);
               _loc5_ = _loc3_.getLocalization("crafting.info.result.ok","crafting.info.result.ok");
               _loc8_ = _loc7_.localizedName;
               setButtonVisible(false);
               break;
            case 1000:
               _loc5_ = "${crafting.info.working}";
               setButtonVisible(false);
         }
         _loc10_ = mainWindow.findChildByName("info_text1") as ITextWindow;
         if(_loc10_)
         {
            _loc10_.text = _loc5_;
         }
         _loc10_ = mainWindow.findChildByName("info_text2") as ITextWindow;
         if(_loc10_)
         {
            _loc10_.text = _loc8_;
         }
      }
      
      private function enableButton() : void
      {
         setButtonVisible(true);
         var _loc1_:UnknownICoreWindowComponents4 = !!mainWindow ? mainWindow.findChildByName("btn_craft") as UnknownICoreWindowComponents4 : null;
         if(_loc1_ == null)
         {
            return;
         }
         if(UnknownVarFromCraftingInfoController_CraftingWidget_1.handler.isOwner)
         {
            _loc1_.caption = "${crafting.btn.craft}";
            _loc1_.enable();
            _loc1_.procedure = onCraftTriggered;
         }
         else
         {
            _loc1_.caption = "${crafting.btn.notowner}";
            _loc1_.disable();
         }
      }
      
      private function disableButtonWith(param1:String) : void
      {
         setButtonVisible(true);
         var _loc2_:UnknownICoreWindowComponents4 = !!mainWindow ? mainWindow.findChildByName("btn_craft") as UnknownICoreWindowComponents4 : null;
         if(_loc2_ == null)
         {
            return;
         }
         if(UnknownVarFromCraftingInfoController_CraftingWidget_1.handler.isOwner)
         {
            _loc2_.caption = param1;
         }
         else
         {
            _loc2_.caption = "${crafting.btn.notowner}";
         }
         _loc2_.disable();
      }
      
      public function craftingSecretRecipesAvailable(param1:int, param2:Boolean) : void
      {
         if(param2)
         {
            if(param1 == 0)
            {
               setState(3);
            }
            else
            {
               setState(4,param1);
            }
         }
         else if(param1 > 0)
         {
            setState(5,param1);
         }
         else
         {
            setState(2);
         }
      }
      
      private function onCraftTriggered(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_DOWN")
         {
            return;
         }
         showProgressBar();
      }
      
      private function clearIcon() : void
      {
         setIconBitmapData(null);
         alignElements();
      }
      
      private function requestIconFromRoomEngine(param1:IFurnitureData) : void
      {
         var _loc2_:UnknownHabboRoom1 = null;
         switch(param1.type)
         {
            case "s":
               _loc2_ = UnknownVarFromCraftingInfoController_CraftingWidget_1.handler.container.roomEngine.getFurnitureIcon(param1.id,this);
               break;
            case "i":
               _loc2_ = UnknownVarFromCraftingInfoController_CraftingWidget_1.handler.container.roomEngine.getWallItemIcon(param1.id,this);
         }
         if(_loc2_.data)
         {
            imageReady(0,_loc2_.data);
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         setIconBitmapData(param2);
         alignElements();
      }
      
      public function imageFailed(param1:int) : void
      {
         setIconBitmapData(null);
         alignElements();
      }
      
      private function alignElements() : void
      {
      }
      
      private function showProgressBar() : void
      {
         if(UnknownVarFromCraftingInfoController_CraftingWidget_1 == null || UnknownVarFromCraftingInfoController_CraftingWidget_1.handler == null)
         {
            return;
         }
         UnknownVarFromCraftingInfoController_CraftingWidget_1.handler.craftingInProgress = true;
         setButtonVisible(false);
         UnknownVarFromCraftingInfoController_CraftingProgressBarController_1.show();
      }
      
      public function cancelCrafting() : void
      {
         UnknownVarFromCraftingInfoController_CraftingWidget_1.handler.craftingInProgress = false;
         UnknownVarFromCraftingInfoController_CraftingProgressBarController_1.hide();
         setButtonVisible(true);
      }
      
      public function onProgressBarComplete() : void
      {
         UnknownVarFromCraftingInfoController_CraftingProgressBarController_1.hide();
         UnknownVarFromCraftingInfoController_CraftingWidget_1.doCrafting();
      }
      
      private function setIconBitmapData(param1:BitmapData) : void
      {
         var _loc2_:IBitmapWrapperController = !!mainWindow ? IBitmapWrapperController(mainWindow.findChildByName("furniture_icon")) : null;
         if(!_loc2_)
         {
            return;
         }
         _loc2_.bitmap = param1;
      }
      
      private function setButtonVisible(param1:Boolean) : void
      {
         var _loc2_:IWindowModel = !!mainWindow ? mainWindow.findChildByName("btn_craft") : null;
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
      }
      
      public function get mainWindow() : IWindowController_1
      {
         return UnknownVarFromCraftingInfoController_CraftingWidget_1.window;
      }
   }
}

