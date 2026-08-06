package com.sulake.habbo.communication.messages.outgoing.inventory.badges
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetActivatedBadgesComposer implements IMessageComposer
   {
      private var UnknownVarFromSetActivatedBadgesComposer_Array_1:Array;
      
      private const UnknownConstFromSetActivatedBadgesComposer_Int_1:int = 5;
      
      public function SetActivatedBadgesComposer()
      {
         super();
         UnknownVarFromSetActivatedBadgesComposer_Array_1 = [];
      }
      
      public function addActivatedBadge(param1:String) : void
      {
         if(UnknownVarFromSetActivatedBadgesComposer_Array_1.length >= 5)
         {
            return;
         }
         UnknownVarFromSetActivatedBadgesComposer_Array_1.push(param1);
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            if(_loc2_ <= UnknownVarFromSetActivatedBadgesComposer_Array_1.length)
            {
               _loc1_.push(_loc2_);
               _loc1_.push(UnknownVarFromSetActivatedBadgesComposer_Array_1[_loc2_ - 1]);
            }
            else
            {
               _loc1_.push(_loc2_);
               _loc1_.push("");
            }
            _loc2_++;
         }
         return _loc1_;
      }
   }
}

