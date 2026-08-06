package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxOptionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.NumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextualButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedTextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.RewardListPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.RewardRowPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class GiveReward extends DefaultActionType
   {
      private static const MAX_REWARDS:int = 20;
      
      private static const DEFAULT_REWARDS:int = 5;
      
      private var UnknownVarFromGiveReward_CheckboxOptionPreset_1:CheckboxOptionPreset;
      
      private var _prizeLimitCheckbox:CheckboxGroupPreset;
      
      private var UnknownVarFromGiveReward_NumberInputPreset_1:NumberInputPreset;
      
      private var UnknownVarFromGiveReward_TextPreset_1:TextPreset;
      
      private var UnknownVarFromGiveReward_Int_1:int;
      
      private var _rewardIntervalGroup:RadioGroupPreset;
      
      private var UnknownVarFromGiveReward_NamedTextInputPreset_1:NamedTextInputPreset;
      
      private var _uniquePrizeCheckbox:CheckboxGroupPreset;
      
      private var UnknownVarFromGiveReward_RewardListPreset_1:RewardListPreset;
      
      private var UnknownVarFromGiveReward_TextualButtonPreset_1:TextualButtonPreset;
      
      private var _displayedRewards:int = 5;
      
      public function GiveReward()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.GIVE_REWARD;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function validate() : String
      {
         var _loc2_:int = 0;
         var _loc3_:RewardRowPreset = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc1_:Boolean = _uniquePrizeCheckbox.get(0).selected;
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromGiveReward_RewardListPreset_1.displayedRewards)
         {
            _loc3_ = UnknownVarFromGiveReward_RewardListPreset_1.getRow(_loc2_);
            _loc4_ = validateReward(_loc3_,_loc1_);
            if(_loc4_ != null)
            {
               return _loc4_;
            }
            if(!_loc1_ && _loc3_.probabilityText != "")
            {
               _loc5_ += int(_loc3_.probabilityText);
            }
            _loc2_++;
         }
         if(_loc5_ > 100)
         {
            return "The sum of probabilities cannot exceed 100. You now have " + _loc5_ + ".";
         }
         return null;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(_rewardIntervalGroup.selected);
         _loc1_.push(_uniquePrizeCheckbox.get(0).selected ? 1 : 0);
         _loc1_.push(_prizeLimitCheckbox.get(0).selected ? UnknownVarFromGiveReward_NumberInputPreset_1.value : 0);
         var _loc2_:int = int(UnknownVarFromGiveReward_NamedTextInputPreset_1.text);
         _loc1_.push(_loc2_ >= 1 ? _loc2_ : 1);
         return _loc1_;
      }
      
      override public function readStringParamFromForm() : String
      {
         var _loc3_:int = 0;
         var _loc1_:String = null;
         var _loc2_:String = "";
         _loc3_ = 0;
         while(_loc3_ < UnknownVarFromGiveReward_RewardListPreset_1.displayedRewards)
         {
            _loc1_ = getRewardData(UnknownVarFromGiveReward_RewardListPreset_1.getRow(_loc3_));
            if(_loc1_ != null)
            {
               _loc2_ += (_loc2_ == "" ? "" : ";") + _loc1_;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromGiveReward_NumberInputPreset_1 = param1.createNumberInput(new NumberInputParam(1,1,1000,60));
         var _loc11_:CheckboxOptionParam = new CheckboxOptionParam(roomEvents.localization.getLocalizationWithParams("wiredfurni.params.prizelimit","","amount",""),0);
         _loc11_.extra1 = UnknownVarFromGiveReward_NumberInputPreset_1;
         _prizeLimitCheckbox = param1.createCheckboxGroup([_loc11_],onPrizeLimitToggle);
         UnknownVarFromGiveReward_CheckboxOptionPreset_1 = _prizeLimitCheckbox.get(0);
         var _loc14_:TextParam = new TextParam(1,false);
         _loc14_.textColor = 13369344;
         UnknownVarFromGiveReward_TextPreset_1 = param1.createText("Reward limit not set. Make sure rewards are badges or non-tradeable items.",_loc14_);
         UnknownVarFromGiveReward_Int_1 = UnknownVarFromGiveReward_TextPreset_1.window.height;
         var _loc13_:SimpleListViewPreset = param1.createSimpleListView(true,[_prizeLimitCheckbox,UnknownVarFromGiveReward_TextPreset_1]);
         var _loc6_:SectionPreset = param1.createSection("Reward limit",_loc13_);
         var _loc9_:Array = [new RadioButtonParam(0,"Once"),new RadioButtonParam(1,"1 / n Days"),new RadioButtonParam(2,"1 / n Hours"),new RadioButtonParam(3,"1 / n Mins")];
         _rewardIntervalGroup = param1.createRadioGroup(_loc9_,onRewardIntervalChange,2);
         UnknownVarFromGiveReward_NamedTextInputPreset_1 = param1.createNamedTextInput(new TextInputParam("1",4,null,60,"0-9"),"n =");
         var _loc7_:SimpleListViewPreset = param1.createSimpleListView(true,[_rewardIntervalGroup,UnknownVarFromGiveReward_NamedTextInputPreset_1]);
         var _loc12_:SectionPreset = param1.createSection("How often can a user be rewarded",_loc7_);
         var _loc15_:CheckboxOptionParam = new CheckboxOptionParam("Unique Rewards?",0);
         var _loc8_:TextPreset = param1.createText("If checked each reward will be given once to each user. Probabilities are not in use.",new TextParam(1,false));
         _loc15_.extra2 = _loc8_;
         _uniquePrizeCheckbox = param1.createCheckboxGroup([_loc15_],onUniquePrizeToggle);
         var _loc4_:SectionPreset = param1.createSection("Unique Rewards",_uniquePrizeCheckbox);
         UnknownVarFromGiveReward_RewardListPreset_1 = param1.createRewardList(20,_displayedRewards);
         UnknownVarFromGiveReward_TextualButtonPreset_1 = param1.createTextualButtonPreset("Add reward",onAddReward);
         var _loc5_:SectionParam = new SectionParam();
         _loc5_.addHeaderOption(UnknownVarFromGiveReward_TextualButtonPreset_1);
         var _loc10_:SectionPreset = param1.createSection("Rewards",UnknownVarFromGiveReward_RewardListPreset_1,_loc5_);
         param3.addElements(_loc6_,_loc12_,_loc4_,_loc10_);
         updatePrizeLimitState();
         onRewardIntervalChange(_rewardIntervalGroup.selected);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc4_:int = 0;
         var _loc5_:RewardRowPreset = null;
         _rewardIntervalGroup.selected = param1.intParams[0];
         if(_rewardIntervalGroup.selected > 0 && param1.intParams.length == 4)
         {
            UnknownVarFromGiveReward_NamedTextInputPreset_1.text = String(param1.intParams[3]);
         }
         else
         {
            UnknownVarFromGiveReward_NamedTextInputPreset_1.text = "1";
         }
         onRewardIntervalChange(_rewardIntervalGroup.selected);
         var _loc3_:* = param1.intParams[1] == 1;
         _uniquePrizeCheckbox.get(0).selected = _loc3_;
         setProbabilityVisibility(!_loc3_);
         var _loc2_:int = int(param1.intParams[2]);
         if(_loc2_ > 0)
         {
            UnknownVarFromGiveReward_NumberInputPreset_1.value = _loc2_;
            _prizeLimitCheckbox.get(0).selected = true;
         }
         else
         {
            _prizeLimitCheckbox.get(0).selected = false;
         }
         updatePrizeLimitState();
         _displayedRewards = 5;
         var _loc6_:Array = param1.stringParam == "" ? [] : param1.stringParam.split(";");
         _loc4_ = 0;
         while(_loc4_ < 20)
         {
            _loc5_ = UnknownVarFromGiveReward_RewardListPreset_1.getRow(_loc4_);
            if(_loc6_[_loc4_])
            {
               setRewardData(_loc5_,_loc6_[_loc4_]);
               _displayedRewards = Math.max(_displayedRewards,_loc4_ + 1);
            }
            else
            {
               _loc5_.clear();
            }
            _loc4_++;
         }
         UnknownVarFromGiveReward_RewardListPreset_1.setDisplayedRewards(_displayedRewards);
      }
      
      private function onPrizeLimitToggle(param1:int, param2:Boolean) : void
      {
         if(param1 == 0)
         {
            updatePrizeLimitState();
         }
      }
      
      private function updatePrizeLimitState() : void
      {
         var _loc1_:Boolean = _prizeLimitCheckbox.get(0).selected;
         UnknownVarFromGiveReward_TextPreset_1.visible = !_loc1_;
         UnknownVarFromGiveReward_TextPreset_1.window.height = _loc1_ ? 0 : UnknownVarFromGiveReward_Int_1;
      }
      
      private function onUniquePrizeToggle(param1:int, param2:Boolean) : void
      {
         if(param1 == 0)
         {
            setProbabilityVisibility(!param2);
         }
      }
      
      private function setProbabilityVisibility(param1:Boolean) : void
      {
         UnknownVarFromGiveReward_RewardListPreset_1.setProbabilityEnabled(param1);
      }
      
      private function onAddReward() : void
      {
         _displayedRewards = Math.min(20,_displayedRewards + 1);
         UnknownVarFromGiveReward_RewardListPreset_1.setDisplayedRewards(_displayedRewards);
      }
      
      private function onRewardIntervalChange(param1:int) : void
      {
         UnknownVarFromGiveReward_NamedTextInputPreset_1.disabled = param1 == 0;
      }
      
      private function validateReward(param1:RewardRowPreset, param2:Boolean) : String
      {
         var _loc5_:int = 0;
         var _loc4_:String = param1.code;
         var _loc3_:String = param1.probabilityText;
         if(_loc4_ == "" && _loc3_ == "")
         {
            return null;
         }
         if(_loc4_.indexOf(",") > 0)
         {
            return "Product/badge codes must not contain \',\' characters.";
         }
         if(_loc4_.indexOf(";") > 0)
         {
            return "Product/badge codes must not contain \';\' characters.";
         }
         var _loc6_:int = 100;
         if(_loc4_.length > _loc6_)
         {
            return "Product/badge codes cannot contain more than " + _loc6_ + " characters.";
         }
         if(_loc4_ == "")
         {
            return "Remember to define product/badge codes for all rewards (fill all fields or leave all fields empty).";
         }
         if(!param2)
         {
            if(_loc3_ == "")
            {
               return "Remember to define probabilities for all rewards (fill all fields or leave all fields empty).";
            }
            if(isNaN(Number(_loc3_)))
            {
               return "Make sure are probabilities are numbers.";
            }
            _loc5_ = int(_loc3_);
            if(_loc5_ < 1 || _loc5_ > 100)
            {
               return "Make sure all probabilities are numbers between 1 and 100.";
            }
         }
         return null;
      }
      
      private function getRewardData(param1:RewardRowPreset) : String
      {
         var _loc3_:String = param1.code;
         var _loc5_:String = param1.probabilityText;
         var _loc2_:Boolean = param1.isBadge;
         _loc3_ = replaceAll(_loc3_,";","");
         _loc3_ = replaceAll(_loc3_,",","");
         if(_loc3_ == "")
         {
            return null;
         }
         var _loc4_:int = int(isNaN(Number(_loc5_)) ? 0 : int(_loc5_));
         return (_loc2_ ? "0" : "1") + "," + _loc3_ + "," + _loc4_;
      }
      
      private function setRewardData(param1:RewardRowPreset, param2:String) : void
      {
         var _loc3_:Array = param2 == null ? [] : param2.split(",");
         param1.code = !!_loc3_[1] ? _loc3_[1] : "";
         param1.probabilityText = !!_loc3_[2] ? _loc3_[2] : "";
         param1.isBadge = _loc3_[0] && _loc3_[0] == "0";
      }
      
      private function replaceAll(param1:String, param2:String, param3:String) : String
      {
         var _loc4_:int = 100;
         while(param1.indexOf(param2) > -1)
         {
            param1 = param1.replace(param2,param3);
            _loc4_--;
            if(_loc4_ < 1)
            {
               break;
            }
         }
         return param1;
      }
   }
}

