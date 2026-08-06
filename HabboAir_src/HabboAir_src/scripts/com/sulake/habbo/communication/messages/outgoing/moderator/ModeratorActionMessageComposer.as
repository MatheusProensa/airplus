package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ModeratorActionMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      public static const UnknownConstFromModeratorActionMessageComposer_Int_1:int = 0;
      
      public static const UnknownConstFromModeratorActionMessageComposer_Int_2:int = 1;
      
      public static const UnknownConstFromModeratorActionMessageComposer_Int_3:int = 3;
      
      public static const UnknownConstFromModeratorActionMessageComposer_Int_4:int = 4;
      
      private var UnknownVarFromModeratorActionMessageComposer_Array_1:Array = [];
      
      public function ModeratorActionMessageComposer(param1:int, param2:String, param3:String)
      {
         super();
         this.UnknownVarFromModeratorActionMessageComposer_Array_1.push(param1);
         this.UnknownVarFromModeratorActionMessageComposer_Array_1.push(param2);
         this.UnknownVarFromModeratorActionMessageComposer_Array_1.push(param3);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromModeratorActionMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromModeratorActionMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

