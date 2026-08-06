package com.sulake.core.runtime
{
   public class ComponentDependency
   {
      private var _identifier:IID;
      
      private var _dependencySetter:Function;
      
      private var _isRequired:Boolean;
      
      private var _eventListeners:Array;
      
      public function ComponentDependency(param1:IID, param2:Function, param3:Boolean = true, param4:Array = null)
      {
         super();
         _identifier = param1;
         _dependencySetter = param2;
         _isRequired = param3;
         _eventListeners = param4;
      }
      
      internal function get identifier() : IID
      {
         return _identifier;
      }
      
      internal function get dependencySetter() : Function
      {
         return _dependencySetter;
      }
      
      internal function get isRequired() : Boolean
      {
         return _isRequired;
      }
      
      internal function get eventListeners() : Array
      {
         return _eventListeners;
      }
   }
}

