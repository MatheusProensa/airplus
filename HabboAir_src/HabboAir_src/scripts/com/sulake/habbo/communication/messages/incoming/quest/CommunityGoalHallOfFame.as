package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class CommunityGoalHallOfFame implements IComponentInterfaceQueue
   {
      private var _goalCode:String;
      
      private var _hof:Array;
      
      public function CommunityGoalHallOfFame(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         _hof = [];
         super();
         _goalCode = param1.readString();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _hof.push(new HallOfFameEntryData(param1));
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         _hof = null;
      }
      
      public function get disposed() : Boolean
      {
         return _hof == null;
      }
      
      public function get hof() : Array
      {
         return _hof;
      }
      
      public function get goalCode() : String
      {
         return _goalCode;
      }
   }
}

