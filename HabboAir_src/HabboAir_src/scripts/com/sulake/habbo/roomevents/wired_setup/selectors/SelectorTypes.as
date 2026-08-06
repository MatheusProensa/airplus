package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.SelectorDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.IDefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.UnknownIHabboRoomeventsWired_Setup1;
   
   public class SelectorTypes implements UnknownIHabboRoomeventsWired_Setup1
   {
      private var _types:Array = [];
      
      public function SelectorTypes()
      {
         super();
         this._types.push(new FurniByType());
         this._types.push(new UnknownHabboRoomeventsWired_SetupSelectors1());
         this._types.push(new UsersByType());
         this._types.push(new UsersInTeam());
         this._types.push(new FurniOnFurni());
         this._types.push(new FurniFromSignal());
         this._types.push(new UnknownHabboRoomeventsWired_SetupSelectors3());
         this._types.push(new FurniInArea());
         this._types.push(new UsersOnFurni());
         this._types.push(new UsersPerformingAction());
         this._types.push(new UsersFromSignal());
         this._types.push(new UsersByName());
         this._types.push(new UsersInNeighborhood());
         this._types.push(new UsersInArea());
         this._types.push(new UsersWithHanditem());
         this._types.push(new UsersInGroup());
         this._types.push(new FurniWithAltitude());
         this._types.push(new UnknownHabboRoomeventsWired_SetupSelectors2());
         this._types.push(new UsersWithVariable());
         this._types.push(new RemoteSelector());
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
         return "selector";
      }
      
      public function acceptTriggerable(param1:Triggerable) : Boolean
      {
         return param1 as SelectorDefinition != null;
      }
   }
}

