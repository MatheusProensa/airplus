package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.VariableDefinition;
   import com.sulake.habbo.roomevents.wired_setup.IDefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.UnknownIHabboRoomeventsWired_Setup1;
   
   public class VariableTypes implements UnknownIHabboRoomeventsWired_Setup1
   {
      private var _types:Array = [];
      
      public function VariableTypes()
      {
         super();
         _types.push(new FurniVariable());
         _types.push(new UserVariable());
         _types.push(new GlobalVariable());
         _types.push(new ContextVariable());
         _types.push(new ReferenceVariable());
         _types.push(new QuestVariable());
         _types.push(new QuestChainVariable());
         _types.push(new EchoVariable());
         _types.push(new DailyTaskVariable());
      }
      
      public function getElementByCode(param1:int) : IDefaultElement
      {
         for each(var _loc2_ in _types)
         {
            if(_loc2_.code == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getKey() : String
      {
         return "variable";
      }
      
      public function acceptTriggerable(param1:Triggerable) : Boolean
      {
         return param1 as VariableDefinition != null;
      }
   }
}

