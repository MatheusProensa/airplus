package com.sulake.habbo.groups
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.users.IGuildEditData;
   
   public class GuildSettingsCtrl
   {
      public static const TYPE_REGULAR:int = 0;
      
      public static const TYPE_EXCLUSIVE:int = 1;
      
      public static const UnknownConstFromHabboGroupDetailsData_Int_1:int = 2;
      
      public static const TYPE_LARGE:int = 3;
      
      public static const UnknownConstFromHabboGroupDetailsData_Int_2:int = 4;
      
      public static const RIGHTS_MEMBERS:int = 0;
      
      public static const UnknownConstFromGuildSettingsCtrl_Int_1:int = 1;
      
      private var UnknownVarFromGuildSettingsCtrl_GuildSettingsData_1:GuildSettingsData;
      
      private var UnknownVarFromGuildSettingsCtrl_ISelectorWindow_1:ISelectorWindow;
      
      private var UnknownVarFromGuildSettingsCtrl_IRadioButtonWindow_1:IRadioButtonWindow;
      
      private var UnknownVarFromGuildSettingsCtrl_IRadioButtonWindow_2:IRadioButtonWindow;
      
      private var UnknownVarFromGuildSettingsCtrl_IRadioButtonWindow_3:IRadioButtonWindow;
      
      private var UnknownVarFromGuildSettingsCtrl_UnknownICoreWindowComponents2_1:UnknownICoreWindowComponents2;
      
      public function GuildSettingsCtrl()
      {
         super();
      }
      
      public function prepare(param1:IWindowController_1) : void
      {
         var _loc2_:IWindowController_1 = param1.findChildByName("step_cont_5") as IWindowController_1;
         UnknownVarFromGuildSettingsCtrl_ISelectorWindow_1 = _loc2_.findChildByName("group_type_selector") as ISelectorWindow;
         UnknownVarFromGuildSettingsCtrl_IRadioButtonWindow_1 = _loc2_.findChildByName("rb_type_regular") as IRadioButtonWindow;
         UnknownVarFromGuildSettingsCtrl_IRadioButtonWindow_1.procedure = onRegularGuildType;
         UnknownVarFromGuildSettingsCtrl_IRadioButtonWindow_2 = _loc2_.findChildByName("rb_type_exclusive") as IRadioButtonWindow;
         UnknownVarFromGuildSettingsCtrl_IRadioButtonWindow_2.procedure = onExclusiveGuildType;
         UnknownVarFromGuildSettingsCtrl_IRadioButtonWindow_3 = _loc2_.findChildByName("rb_type_private") as IRadioButtonWindow;
         UnknownVarFromGuildSettingsCtrl_IRadioButtonWindow_3.procedure = onPrivateGuildType;
         UnknownVarFromGuildSettingsCtrl_UnknownICoreWindowComponents2_1 = _loc2_.findChildByName("cb_member_rights") as UnknownICoreWindowComponents2;
         UnknownVarFromGuildSettingsCtrl_UnknownICoreWindowComponents2_1.procedure = onMembersHaveRights;
      }
      
      public function refresh(param1:IGuildEditData) : void
      {
         UnknownVarFromGuildSettingsCtrl_GuildSettingsData_1 = new GuildSettingsData(param1);
         switch(UnknownVarFromGuildSettingsCtrl_GuildSettingsData_1.guildType)
         {
            case 0:
               UnknownVarFromGuildSettingsCtrl_ISelectorWindow_1.setSelected(UnknownVarFromGuildSettingsCtrl_IRadioButtonWindow_1);
               break;
            case 1:
               UnknownVarFromGuildSettingsCtrl_ISelectorWindow_1.setSelected(UnknownVarFromGuildSettingsCtrl_IRadioButtonWindow_2);
               break;
            case 2:
               UnknownVarFromGuildSettingsCtrl_ISelectorWindow_1.setSelected(UnknownVarFromGuildSettingsCtrl_IRadioButtonWindow_3);
               break;
            default:
               UnknownVarFromGuildSettingsCtrl_ISelectorWindow_1.setSelected(UnknownVarFromGuildSettingsCtrl_IRadioButtonWindow_1);
         }
         if(UnknownVarFromGuildSettingsCtrl_GuildSettingsData_1.rightsLevel == 0)
         {
            UnknownVarFromGuildSettingsCtrl_UnknownICoreWindowComponents2_1.select();
         }
         else
         {
            UnknownVarFromGuildSettingsCtrl_UnknownICoreWindowComponents2_1.unselect();
         }
         UnknownVarFromGuildSettingsCtrl_ISelectorWindow_1.invalidate();
      }
      
      private function onRegularGuildType(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WE_SELECT")
         {
            UnknownVarFromGuildSettingsCtrl_GuildSettingsData_1.guildType = 0;
         }
      }
      
      private function onExclusiveGuildType(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WE_SELECT")
         {
            UnknownVarFromGuildSettingsCtrl_GuildSettingsData_1.guildType = 1;
         }
      }
      
      private function onPrivateGuildType(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WE_SELECT")
         {
            UnknownVarFromGuildSettingsCtrl_GuildSettingsData_1.guildType = 2;
         }
      }
      
      private function onMembersHaveRights(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WE_SELECT")
         {
            UnknownVarFromGuildSettingsCtrl_GuildSettingsData_1.rightsLevel = 0;
         }
         if(param1.type == "WE_UNSELECT")
         {
            UnknownVarFromGuildSettingsCtrl_GuildSettingsData_1.rightsLevel = 1;
         }
      }
      
      public function resetModified() : void
      {
         if(UnknownVarFromGuildSettingsCtrl_GuildSettingsData_1 != null && UnknownVarFromGuildSettingsCtrl_GuildSettingsData_1.isModified)
         {
            UnknownVarFromGuildSettingsCtrl_GuildSettingsData_1.resetModified();
         }
      }
      
      public function get guildType() : int
      {
         return UnknownVarFromGuildSettingsCtrl_GuildSettingsData_1.guildType;
      }
      
      public function get rightsLevel() : int
      {
         return UnknownVarFromGuildSettingsCtrl_GuildSettingsData_1.rightsLevel;
      }
      
      public function get isInitialized() : Boolean
      {
         return UnknownVarFromGuildSettingsCtrl_GuildSettingsData_1 != null;
      }
   }
}

