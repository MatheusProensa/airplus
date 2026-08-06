package com.sulake.habbo.avatar.structure
{
   import com.sulake.habbo.avatar.actions.ActionDefinition;
   import com.sulake.habbo.avatar.actions.IActionDefinition;
   import com.sulake.habbo.avatar.structure.parts.*;
   import flash.utils.Dictionary;
   
   public class PartSetsData implements IStructureData
   {
      private var _parts:Dictionary;
      
      private var _activePartSets:Dictionary;
      
      public function PartSetsData()
      {
         super();
         _parts = new Dictionary();
         _activePartSets = new Dictionary();
      }
      
      public function parse(param1:XML) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         for each(var _loc3_ in param1.partSet[0].part)
         {
            _parts[String(_loc3_["set-type"])] = new PartDefinition(_loc3_);
         }
         for each(var _loc2_ in param1.activePartSet)
         {
            _activePartSets[String(_loc2_.@id)] = new ActivePartSet(_loc2_);
         }
         return true;
      }
      
      public function appendXML(param1:XML) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         for each(var _loc3_ in param1.partSet[0].part)
         {
            _parts[String(_loc3_["set-type"])] = new PartDefinition(_loc3_);
         }
         for each(var _loc2_ in param1.activePartSet)
         {
            _activePartSets[String(_loc2_.@id)] = new ActivePartSet(_loc2_);
         }
         return false;
      }
      
      public function getActiveParts(param1:IActionDefinition) : Array
      {
         var _loc2_:ActivePartSet = _activePartSets[param1.activePartSet];
         if(_loc2_ != null)
         {
            return _loc2_.parts;
         }
         return [];
      }
      
      public function getPartDefinition(param1:String) : PartDefinition
      {
         return _parts[param1] as PartDefinition;
      }
      
      public function addPartDefinition(param1:XML) : PartDefinition
      {
         var _loc2_:String = String(param1["set-type"]);
         if(_parts[_loc2_] == null)
         {
            _parts[_loc2_] = new PartDefinition(param1);
         }
         return _parts[_loc2_];
      }
      
      public function get parts() : Dictionary
      {
         return _parts;
      }
      
      public function get activePartSets() : Dictionary
      {
         return _activePartSets;
      }
      
      public function getActivePartSet(param1:ActionDefinition) : ActivePartSet
      {
         return _activePartSets[param1.activePartSet] as ActivePartSet;
      }
   }
}

