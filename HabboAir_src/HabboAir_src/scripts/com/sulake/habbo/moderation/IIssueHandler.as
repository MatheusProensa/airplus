package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public interface IIssueHandler extends IComponentInterfaceQueue
   {
      function updateIssuesAndMessages() : void;
      
      function showDefaultSanction(param1:int, param2:String) : void;
   }
}

