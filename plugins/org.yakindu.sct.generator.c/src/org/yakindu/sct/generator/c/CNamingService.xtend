/**
  Copyright (c) 2014-2015 committers of YAKINDU Statechart Tools.
  All rights reserved. This program and the accompanying materials
  are made available under the terms of the Eclipse Public License v1.0
  which accompanies this distribution, and is available at
  http://www.eclipse.org/legal/epl-v10.html
  
  Contributors:
  	Markus Mühlbrandt - Initial contribution and API
*/

package org.yakindu.sct.generator.c

import com.google.inject.Inject
import java.util.Arrays
import java.util.Map
import org.yakindu.base.base.NamedElement
import org.yakindu.sct.generator.c.extensions.GenmodelEntries
import org.yakindu.sct.model.sexec.ExecutionFlow
import org.yakindu.sct.model.sexec.ExecutionState
import org.yakindu.sct.model.sexec.Step
import org.yakindu.sct.model.sexec.extensions.SExecExtensions
import org.yakindu.sct.model.sexec.naming.DefaultNamingService
import org.yakindu.sct.model.sgen.GeneratorEntry
import org.yakindu.sct.model.sgraph.State
import org.yakindu.sct.model.sgraph.Statechart
import org.yakindu.sct.model.stext.stext.TimeEventSpec

import static org.yakindu.sct.generator.c.CKeywords.*

public class CNamingService extends DefaultNamingService {
	
	@Inject
	extension GenmodelEntries
	@Inject
	extension SExecExtensions
	@Inject
	var GeneratorEntry entry
	
	override void initializeNamingService(Statechart statechart) {
		if (entry.identifierLength != null) {
			maxLength = entry.identifierLength
		}
		
		if (entry.separator != null) {
			separator = entry.separator.charAt(0)
		}
		
		super.initializeNamingService(statechart)
	}
	
	override void initializeNamingService(ExecutionFlow flow) {
		if (entry.identifierLength != null) {
			maxLength = entry.identifierLength
		}
		
		if (entry.separator != null) {
			separator = entry.separator.charAt(0)
		}
		
		super.initializeNamingService(flow)
	}
	
	override Map<NamedElement, String> getShortNameMap(ExecutionFlow flow) {
		if (entry.identifierLength != null) {
			maxLength = entry.identifierLength
		}
		
		if (entry.separator != null) {
			separator = entry.separator.charAt(0)
		}
		
		return super.getShortNameMap(flow)
	}
	
	override Map<NamedElement, String> getShortNameMap(Statechart statechart) {
		if (entry.identifierLength != null) {
			maxLength = entry.identifierLength
		}
		
		if (entry.separator != null) {
			separator = entry.separator.charAt(0)
		}
		
		return super.getShortNameMap(statechart)
	}
	
	override protected prefix(Step it, char separator) {
		var prefix = flow.name.toFirstLower
		if (entry.statemachinePrefix != null) {
			prefix = entry.statemachinePrefix
		}
		switch (it) {
			case isCheckFunction: prefix + separator + "check"
			case isEntryAction: prefix + separator + "enact"
			case isExitAction: prefix + separator + "exact"
			case isEffect: prefix + separator + "effect"
			case isEnterSequence: prefix + separator + "enseq"
			case isDeepEnterSequence: prefix + separator + "dhenseq"
			case isShallowEnterSequence: prefix + separator + "shenseq"
			case isExitSequence: prefix + separator + "exseq"
			case isReactSequence: prefix + separator + "react"
			default: ""
		}
	}
	
	override protected prefix(ExecutionState it, char separator) {
		if (entry.statemachinePrefix.nullOrEmpty) {
			super.prefix(it, separator).toFirstUpper			
		} else {
			entry.statemachinePrefix
		}
	}
	
	override protected prefix(State it, char separator) {
		if (entry.statemachinePrefix.nullOrEmpty) {
			super.prefix(it, separator).toFirstUpper
		} else {
			entry.statemachinePrefix
		}
	}
	
	override protected prefix(TimeEventSpec it, NamedElement element, char separator) {
		if (entry.statemachinePrefix.nullOrEmpty) {
			super.prefix(it, element, separator).toFirstLower
		} else {
			entry.statemachinePrefix
		}
	}
	
	override asEscapedIdentifier(String it) {
		var s = it
		if (s.isKeyword) {
			s = s + separator +'ID'
		}
		return s.asIdentifier
	}
	
	override boolean isKeyword(String name) {
		return !Arrays::asList(C_KEYWORDS).findFirst[it.equalsIgnoreCase(name)].nullOrEmpty
	}
}