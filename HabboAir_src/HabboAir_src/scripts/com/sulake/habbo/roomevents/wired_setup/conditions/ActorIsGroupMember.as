package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupEntryData;
   import com.sulake.habbo.communication.messages.outgoing.users.GetGuildMembershipsMessageComposer;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ActorIsGroupMember extends DefaultConditionType
   {
      private static var REQUEST_TIMEOUT:int = 5;
      
      private var UnknownVarFromActorIsGroupMember_Array_1:Array;
      
      private var UnknownVarFromActorIsGroupMember_Int_1:int = -1;
      
      private var UnknownVarFromActorIsGroupMember_Number_1:Number = 0;
      
      private var UnknownVarFromActorIsGroupMember_RadioGroupPreset_1:RadioGroupPreset;
      
      private var _groupDropdown:DropdownPreset;
      
      public function ActorIsGroupMember()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.ACTOR_IS_GROUP_MEMBER;
      }
      
      override public function get negativeCode() : int
      {
         return ConditionCodes.NOT_ACTOR_IS_GROUP_MEMBER;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _groupDropdown = param1.createDropdown(new DropdownParam(loc("wiredfurni.tooltip.group"),new Vector.<ExpandableDropdownOption>()));
         UnknownVarFromActorIsGroupMember_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("grouptype.0")),new RadioButtonParam(1,l("grouptype.1"),null,_groupDropdown)]);
         var _loc4_:SectionPreset = param1.createSection(l("groupselection"),UnknownVarFromActorIsGroupMember_RadioGroupPreset_1);
         param3.addElements(_loc4_);
      }
      
      override public function readStringParamFromForm() : String
      {
         if(UnknownVarFromActorIsGroupMember_RadioGroupPreset_1.selected != 1)
         {
            return "";
         }
         var _loc1_:ExpandableDropdownOption = _groupDropdown.selected;
         if(_loc1_ == null)
         {
            return "";
         }
         return _loc1_.id.toString();
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromActorIsGroupMember_Int_1 = param1.stringParam == "" ? -1 : int(param1.stringParam);
         initGuilds(UnknownVarFromActorIsGroupMember_Array_1 == null ? [] : UnknownVarFromActorIsGroupMember_Array_1);
         maybeGetGuildMemberships();
         if(param1.stringParam != "")
         {
            UnknownVarFromActorIsGroupMember_RadioGroupPreset_1.selected = 1;
         }
         else
         {
            UnknownVarFromActorIsGroupMember_RadioGroupPreset_1.selected = 0;
         }
      }
      
      private function maybeGetGuildMemberships() : void
      {
         var _loc1_:Number = new Date().time;
         if(_loc1_ > UnknownVarFromActorIsGroupMember_Number_1 + 1000 * REQUEST_TIMEOUT)
         {
            UnknownVarFromActorIsGroupMember_Number_1 = _loc1_;
            roomEvents.send(new GetGuildMembershipsMessageComposer());
         }
      }
      
      private function initGuilds(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:HabboGroupEntryData = null;
         var _loc3_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         UnknownVarFromActorIsGroupMember_Array_1 = param1;
         _loc4_ = 0;
         while(_loc4_ < UnknownVarFromActorIsGroupMember_Array_1.length)
         {
            _loc2_ = UnknownVarFromActorIsGroupMember_Array_1[_loc4_];
            _loc3_.push(new ExpandableDropdownOption(_loc2_.groupId,_loc2_.groupName));
            _loc4_++;
         }
         _groupDropdown.reinit(_loc3_,UnknownVarFromActorIsGroupMember_Int_1);
      }
      
      override public function onGuildMemberships(param1:GuildMembershipsMessageEvent) : void
      {
         initGuilds(param1.guilds);
      }
   }
}

