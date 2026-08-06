package com.sulake.habbo.roomevents.wired_trading.contracts.subcontrollers
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts.WiredContractContentsMessageParser;
   
   public interface IAddEditContractElement
   {
      function show(param1:WiredContractContentsMessageParser) : void;
      
      function hide() : void;
      
      function addContentsToComposer(param1:Array) : void;
      
      function contractType() : int;
      
      function validate() : String;
      
      function get window() : IWindowModel;
   }
}

