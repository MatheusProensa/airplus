package com.sulake.habbo.roomevents.wired_setup.selectors
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
   
   public class UsersInGroup extends DefaultSelectorType
   {
      private static var REQUEST_TIMEOUT:int = 5;
      
      private var UnknownVarFromUsersInGroup_RadioGroupPreset_1:RadioGroupPreset;
      
      private var _groupDropdown:DropdownPreset;
      
      private var UnknownVarFromUsersInGroup_Array_1:Array;
      
      private var UnknownVarFromUsersInGroup_Int_1:int = -1;
      
      private var UnknownVarFromUsersInGroup_Number_1:Number = 0;
      
      public function UsersInGroup()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.USERS_IN_GROUP;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _groupDropdown = param1.createDropdown(new DropdownParam(loc("wiredfurni.tooltip.group"),new Vector.<ExpandableDropdownOption>()));
         UnknownVarFromUsersInGroup_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("grouptype.0")),new RadioButtonParam(1,l("grouptype.1"),null,_groupDropdown)]);
         var _loc4_:SectionPreset = param1.createSection(l("groupselection"),UnknownVarFromUsersInGroup_RadioGroupPreset_1);
         param3.addElements(_loc4_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromUsersInGroup_Int_1 = param1.stringParam == "" ? -1 : int(param1.stringParam);
         initGuilds(UnknownVarFromUsersInGroup_Array_1 == null ? [] : UnknownVarFromUsersInGroup_Array_1);
         maybeGetGuildMemberships();
         if(param1.stringParam != "")
         {
            UnknownVarFromUsersInGroup_RadioGroupPreset_1.selected = 1;
         }
         else
         {
            UnknownVarFromUsersInGroup_RadioGroupPreset_1.selected = 0;
         }
      }
      
      override public function readStringParamFromForm() : String
      {
         if(UnknownVarFromUsersInGroup_RadioGroupPreset_1.selected != 1)
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
      
      override public function onGuildMemberships(param1:GuildMembershipsMessageEvent) : void
      {
         initGuilds(param1.guilds);
      }
      
      private function maybeGetGuildMemberships() : void
      {
         var _loc1_:Number = new Date().time;
         if(_loc1_ > UnknownVarFromUsersInGroup_Number_1 + 1000 * REQUEST_TIMEOUT)
         {
            UnknownVarFromUsersInGroup_Number_1 = _loc1_;
            roomEvents.send(new GetGuildMembershipsMessageComposer());
         }
      }
      
      private function initGuilds(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:HabboGroupEntryData = null;
         var _loc3_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         UnknownVarFromUsersInGroup_Array_1 = param1;
         _loc4_ = 0;
         while(_loc4_ < UnknownVarFromUsersInGroup_Array_1.length)
         {
            _loc2_ = UnknownVarFromUsersInGroup_Array_1[_loc4_];
            _loc3_.push(new ExpandableDropdownOption(_loc2_.groupId,_loc2_.groupName));
            _loc4_++;
         }
         _groupDropdown.reinit(_loc3_,UnknownVarFromUsersInGroup_Int_1);
      }
   }
}

