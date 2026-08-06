package com.sulake.habbo.catalog.earnings
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.communication.messages.parser.vault.IncomeReward;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class EarningsView implements IComponentInterfaceQueue
   {
      private const ALL_CATEGORIES:int = -1;
      
      private var UnknownVarFromEarningsView_EarningsController_1:EarningsController;
      
      private var _window:IWindowController_1;
      
      private var _rewardCategories:Array = ["tutorial","dailygift","achievements","marketplace","habboclub","levelprogression","roombundlesales","bonusbag","donation","surprise","snowstorm","games","wiredchest","agency"];
      
      public function EarningsView(param1:EarningsController, param2:IHabboWindowManagerComponent)
      {
         super();
         UnknownVarFromEarningsView_EarningsController_1 = param1;
         _window = param2.buildFromXML(XML(UnknownVarFromEarningsView_EarningsController_1.assets.getAssetByName("vault_view_xml").content)) as IWindowController_1;
         _window.procedure = windowProcedure;
         _window.center();
         var _loc3_:IItemListWindow = _window.findChildByName("scrolling_earnings_list") as IItemListWindow;
         if(!UnknownVarFromEarningsView_EarningsController_1.getBoolean("games_icon_enabled"))
         {
            _loc3_.findChildByName("snowstorm_container").visible = false;
         }
         if(!UnknownVarFromEarningsView_EarningsController_1.getBoolean("wired.game_earnings"))
         {
            _loc3_.findChildByName("games_container").visible = false;
            _loc3_.findChildByName("agency_container").visible = false;
         }
         _loc3_.findChildByName("wiredchest_container").visible = false;
      }
      
      private static function getDistinctRewardCategories(param1:Array) : Array
      {
         var _loc2_:Boolean = false;
         var _loc4_:Array = [];
         for each(var _loc3_ in param1)
         {
            _loc2_ = false;
            for each(var _loc5_ in _loc4_)
            {
               if(_loc3_.rewardCategory == _loc5_)
               {
                  _loc2_ = true;
                  break;
               }
            }
            if(!_loc2_)
            {
               _loc4_.push(_loc3_.rewardCategory);
            }
         }
         return _loc4_;
      }
      
      public function onIncomeRewardClaimResponse(param1:int, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(param2)
         {
            if(param1 == -1)
            {
               _loc3_ = 0;
               while(_loc3_ < _rewardCategories.length)
               {
                  updateRewardsForCategory(_loc3_,0,0);
                  setElementEnabled(_rewardCategories[_loc3_] + "_claim_button",false);
                  _loc3_ += 1;
               }
            }
            else
            {
               updateRewardsForCategory(param1,0,0);
            }
         }
         else if(param1 != -1)
         {
            setElementEnabled(_rewardCategories[param1] + "_claim_button",true);
         }
         else
         {
            setElementEnabled("claim_all_btn",true);
         }
      }
      
      public function onIncomeRewardDataReceived(param1:Array) : void
      {
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:Array = [];
         for each(var _loc3_ in getDistinctRewardCategories(param1))
         {
            _loc7_ = 0;
            _loc4_ = 0;
            _loc8_ = 0;
            for each(var _loc9_ in param1)
            {
               if(_loc3_ == _loc9_.rewardCategory)
               {
                  if(_loc9_.rewardType == 0)
                  {
                     _loc7_ += _loc9_.amount;
                  }
                  if(_loc9_.rewardType === 1)
                  {
                     _loc4_ += _loc9_.amount;
                  }
                  if(_loc9_.productCode)
                  {
                     _loc8_++;
                  }
               }
            }
            updateRewardsForCategory(_loc3_,_loc4_,_loc7_,_loc8_);
            if(_loc4_ > 0 || _loc7_ > 0 || _loc8_ > 0)
            {
               _loc6_.push(_rewardCategories[_loc3_]);
            }
         }
         var _loc2_:Boolean = false;
         for each(var _loc10_ in _rewardCategories)
         {
            _loc5_ = false;
            for each(var _loc11_ in _loc6_)
            {
               if(_loc10_ == _loc11_)
               {
                  _loc5_ = true;
                  _loc2_ = true;
                  break;
               }
            }
            if(_loc5_ && _loc10_ == "wiredchest")
            {
               _window.findChildByName("wiredchest_container").visible = true;
            }
            setElementEnabled(_loc10_ + "_claim_button",_loc5_);
         }
         setElementEnabled("claim_all_btn",_loc2_);
      }
      
      private function getTotalDucketsToClaim() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _rewardCategories.length)
         {
            _loc1_ += ducketValueForCategory(_loc2_);
            _loc2_ += 1;
         }
         return _loc1_;
      }
      
      private function ducketValueForCategory(param1:int) : int
      {
         if(param1 == -1)
         {
            return getTotalDucketsToClaim();
         }
         var _loc3_:String = _rewardCategories[param1];
         var _loc2_:IWindowModel = _window.findChildByName(_loc3_ + "DucketValue");
         if(_loc2_ != null)
         {
            return int(_loc2_.caption);
         }
         return 0;
      }
      
      private function updateRewardsForCategory(param1:int, param2:int, param3:int, param4:int = 0) : void
      {
         var _loc6_:IWindowModel = null;
         var _loc8_:String = _rewardCategories[param1];
         var _loc7_:IWindowModel = _window.findChildByName(_loc8_ + "CreditValue");
         if(_loc7_ != null)
         {
            _loc7_.caption = param2.toString();
         }
         var _loc5_:IWindowModel = _window.findChildByName(_loc8_ + "DucketValue");
         if(_loc5_ != null)
         {
            _loc5_.caption = param3.toString();
         }
         if(param4 > 0)
         {
            _loc6_ = _window.findChildByName(_loc8_ + "ProductValue");
            if(_loc6_ != null)
            {
               _loc6_.caption = param4.toString();
            }
         }
      }
      
      private function setElementEnabled(param1:String, param2:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc3_:IWindowModel = _window.findChildByName(param1);
         if(_loc3_ != null)
         {
            param2 ? _loc3_.enable() : _loc3_.disable();
         }
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var claiming:Boolean;
         var claimCategory:int;
         var newAmountOfDuckets:int;
         var currentDuckets:int;
         var softLimit:int;
         var event:WindowEvent = param1;
         var target:IWindowModel = param2;
         if(event.type != "WME_CLICK")
         {
            return;
         }
         claiming = false;
         claimCategory = 0;
         switch(target.name)
         {
            case "vaultWithdraw_button":
            case "vaultWithdrawAll_button":
               UnknownVarFromEarningsView_EarningsController_1.withdrawVaultCredits();
               break;
            case "vaultOpenShop_button":
               UnknownVarFromEarningsView_EarningsController_1.openCatalogue();
               break;
            case "header_button_close":
               dispose();
               break;
            case "dailygift_claim_button":
               claiming = true;
               claimCategory = 1;
               break;
            case "achievements_claim_button":
               claiming = true;
               claimCategory = 2;
               break;
            case "marketplace_claim_button":
               claiming = true;
               claimCategory = 3;
               break;
            case "habboclub_claim_button":
               claiming = true;
               claimCategory = 4;
               break;
            case "levelprogression_claim_button":
               claiming = true;
               claimCategory = 5;
               break;
            case "bonusbag_claim_button":
               claiming = true;
               claimCategory = 7;
               break;
            case "donation_claim_button":
               claiming = true;
               claimCategory = 8;
               break;
            case "surprise_claim_button":
               claiming = true;
               claimCategory = 9;
               break;
            case "snowstorm_claim_button":
               claiming = true;
               claimCategory = 10;
               break;
            case "games_claim_button":
               claiming = true;
               claimCategory = 11;
               break;
            case "wiredchest_claim_button":
               claiming = true;
               claimCategory = 12;
               break;
            case "agency_claim_button":
               claiming = true;
               claimCategory = 13;
               break;
            case "claim_all_btn":
               claiming = true;
               claimCategory = -1;
         }
         if(claiming)
         {
            newAmountOfDuckets = ducketValueForCategory(claimCategory);
            currentDuckets = UnknownVarFromEarningsView_EarningsController_1.catalog.getPurse().getActivityPointsForType(0);
            softLimit = UnknownVarFromEarningsView_EarningsController_1.getInteger("duckets.soft_limit",2147483647);
            if(newAmountOfDuckets > 0 && newAmountOfDuckets + currentDuckets > softLimit)
            {
               UnknownVarFromEarningsView_EarningsController_1.windowManager.confirm("${generic.alert.title}","${earning.exceeding_limit}",0,function(param1:UnknownICoreWindowUtils2, param2:WindowEvent):void
               {
                  param1.dispose();
                  if(param2.type == "WE_OK")
                  {
                     performClaim(target.name,claimCategory);
                  }
               });
            }
            else
            {
               performClaim(target.name,claimCategory);
            }
         }
      }
      
      private function performClaim(param1:String, param2:int) : void
      {
         if(_window == null || UnknownVarFromEarningsView_EarningsController_1 == null)
         {
            return;
         }
         setElementEnabled(param1,false);
         UnknownVarFromEarningsView_EarningsController_1.claimReward(param2);
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         UnknownVarFromEarningsView_EarningsController_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromEarningsView_EarningsController_1 == null;
      }
   }
}

