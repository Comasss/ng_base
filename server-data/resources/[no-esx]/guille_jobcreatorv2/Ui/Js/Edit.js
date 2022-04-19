handleLoad = () => {
    window.addEventListener("message", function (event) {  
        switch(event.data.type) {
            case "loadData":
                JOB.LoadJobs(event.data.JobsData)
        }
    })

    let JOB = []

    JOB.ExecuteCallback = async function(name, data, type, job) {
        return new Promise(resolve => {
            $.post(`https://${GetParentResourceName()}/`+name, JSON.stringify({data: data, type: type || "none", job: job}), function(result) {
                resolve(JSON.parse(result))
            })
        })
    }

    JOB.LoadJobs = (JobsData) => {
        Object.entries(JobsData).forEach(([key, value]) => {
            console.log(key + ' ' + value)
            console.log(JSON.stringify(value['label']))
            $(".edit-wrapper").append(`
            
                <div id="${key}" class="job-wrapper">
                    <a href="#homeSubmenu-${key}" id="homeSubmenu-${key}" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle text" style="color: black; font-size: .7vw;"><strong>${key}</strong></a>
                    <ul class="collapse list-unstyled" id="homeSubmenu-${key}">
                        <li class="item-list">
                            <a href="#homeSubmenu-ranks-${key}" id="homeSubmenu-ranks-${key}" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle text" style="color: black; font-size: .7vw;">Ranks (Coming soon)</a>
                            <ul class="collapse list-unstyled" id="homeSubmenu-ranks-${key}">
                            </ul>
                            <a href="#homeSubmenu-markers-${key}" id="homeSubmenu-markers-${key}" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle text" style="color: black; font-size: .7vw;">Markers</a>
                            <ul class="collapse list-unstyled" id="homeSubmenu-markers-${key}">
                                <li class="item-list">
                                    <div class="edit-ranks" id="edit-markers-${key}">
                                    <div class="save" id="save-markers-${key}"><span class="text" style="font-size: .7vw;">Save</span></div> <div class="save" id="add-markers-${key}"><span class="text" style="font-size: .7vw;">Add</span></div>                                                            
                                    </div>
                                </li>
                            </ul>
                            <a href="#homeSubmenu-vehicles-${key}" id="homeSubmenu-vehicles-${key}" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle text" style="color: black; font-size: .7vw;">Vehicles</a>
                            <ul class="collapse list-unstyled" id="homeSubmenu-vehicles-${key}">
                                <li class="item-list">
                                    <div class="edit-ranks">
                                        <div class="rank-num" id="vehicles-${key}">
                                            
                                        </div>          
                                        <div class="save" id="add-vehicle-${key}" style="background-color: blueviolet;"><span class="text" style="font-size: .4vw;">Add a vehicle</span></div> 
                                        <div class="save" id="save-vehicles-${key}"><span class="text" style="font-size: .7vw;">Save</span></div>                              
                                    </div>
                                </li>
                            </ul>
                            <a class="option">Shop</a>
                            <a href="#homeSubmenu-options-${key}" id="homeSubmenu-options-${key}" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle text" style="color: black; font-size: .7vw;">Options</a>
                            <ul class="collapse list-unstyled" id="homeSubmenu-options-${key}">
                                <li class="item-list">
                                    <div class="edit-ranks" style="gap: 0vw;">
                                        <label class="text" style="color: black; font-size: .7vw;">Handcuff
                                            <input id="handcuff-${key}" type="checkbox" style="transform: scale(0.9);" checked="false">
                                        </label>
                                        <label class="text" style="color: black; font-size: .7vw;">Vehicle info
                                            <input id="vehinfo-${key}" type="checkbox" style="transform: scale(0.9);" checked="false">
                                        </label>
                                        <label class="text" style="color: black; font-size: .7vw;">Check identity
                                            <input id="identity-${key}" type="checkbox" style="transform: scale(0.9);" checked="false">
                                        </label>
                                        <label class="text" style="color: black; font-size: .7vw;">Put objects
                                            <input id="objects-${key}" type="checkbox" style="transform: scale(0.9);" checked="false">
                                        </label>
                                        <label class="text" style="color: black; font-size: .7vw;">Billing (only ESX)
                                            <input id="billing-${key}" type="checkbox" style="transform: scale(0.9);" checked="false">
                                        </label>
                                        <label class="text" style="color: black; font-size: .7vw;">Search 
                                        <input id="search-${key}" type="checkbox" style="transform: scale(0.9);" checked="false">
                                        </label>
                                        <div class="save" name="${key}" id="saveoptions-${key}"><span class="text" style="font-size: .7vw;">Save</span></div>                              
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>            
            `)

            
            $(`#handcuff-${key}`).prop("checked", value['options']['handcuff'])
            $(`#vehinfo-${key}`).prop("checked", value['options']['vehinfo'])
            $(`#identity-${key}`).prop("checked", value['options']['identity'])
            $(`#objects-${key}`).prop("checked", value['options']['objects'])
            $(`#billing-${key}`).prop("checked", value['options']['billing'])
            $(`#search-${key}`).prop("checked", value['options']['search'])

            $(`#saveoptions-${key}`).on("click", function() {
                const name = $(this).attr("name")
                const Data = {
                    handcuff: $(`#handcuff-${name}`).is(":checked"),
                    vehinfo: $(`#vehinfo-${name}`).is(":checked"),
                    identity: $(`#identity-${name}`).is(":checked"),
                    objects: $(`#objects-${name}`).is(":checked"),
                    billing: $(`#billing-${name}`).is(":checked"),
                    search: $(`#search-${name}`).is(":checked")
                }
                JOB.ExecuteCallback("updateInfo", Data, "updateOptions", key)
            })

            $(`#add-markers-${key}`).on("click", async () => {
                markers++
                $(`#edit-markers-${key}`).append(`
                    <div class="rank-num" id="markers-${markers}">
                        <input class="text" id="markere-${markers}-x" style="color: black; text-align: center; width: 50%; font-size: 0.8vw;" placeholder="X" value="0"></input>
                        <input class="text" id="markere-${markers}-y" style="color: black; text-align: center; width: 50%; font-size: 0.8vw;" placeholder="Y" value="0"></input>
                        <input class="text" id="markere-${markers}-z" style="color: black; text-align: center; width: 50%; font-size: 0.8vw;" placeholder="Z" value="0"></input>
                        <select num="${markers}" id="markere-${markers}-selected" style="width: 2vw;">
                            <option value="armory">Stash</option>
                            <option value="getvehs">Get vehicles</option>
                            <option value="savevehs">Save vehicles</option>
                            <option value="boss">Boss</option>
                            <option value="shop">Shop</option>
                            <option value="wardrobe">Wardrobe</option>
                        </select>
                        <div class="button actualcoords" style="position: relative;" num="${markers}" id="markere-${markers}-button" style="background-color: red;"><span class="text" style="font-size: .4vw;">Actual coords</span></div>
                        <div class="button actualcoords" style="position: relative;" num="${markers}" id="markeredelete-${markers}-button" style="background-color: red;"><span class="text" style="font-size: .4vw;">Delete</span></div>
                    </div>  
                `)
                let coords = await JOB.ExecuteCallback("getCoords")
                let axis = ['x', 'y', 'z']
                axis.forEach((ax) => {
                    $(`#markere-${markers}-${ax}`).val(coords[ax])
                })
                $(`#markere-${markers}-button`).on("click", async function() {
                    let coords = await JOB.ExecuteCallback("getCoords")
                    let actualMarker = $(this).attr("num")
                    let axis = ['x', 'y', 'z']
                    axis.forEach((ax) => {
                        $(`#markere-${actualMarker}-${ax}`).val(coords[ax])
                    })
                })
                $(`#markeredelete-${markers}-button`).on("click", function() {
                    let actualMarker = $(this).attr("num")
                    $(`#markers-${actualMarker}`).remove()
                })
            })
            let markers = 0

            value['points'].forEach((val) => {
                markers++
                $(`#edit-markers-${key}`).append(`
                    <div class="rank-num" id="markers-${markers}">
                        <input class="text" id="markere-${markers}-x" style="color: black; text-align: center; width: 50%; font-size: 0.8vw;" placeholder="X" value="${val.x}"></input>
                        <input class="text" id="markere-${markers}-y" style="color: black; text-align: center; width: 50%; font-size: 0.8vw;" placeholder="Y" value="${val.y}"></input>
                        <input class="text" id="markere-${markers}-z" style="color: black; text-align: center; width: 50%; font-size: 0.8vw;" placeholder="Z" value="${val.z}"></input>
                        <select num="${markers}" id="markere-${markers}-selected" style="width: 2vw;">
                            <option value="armory">Stash</option>
                            <option value="getvehs">Get vehicles</option>
                            <option value="savevehs">Save vehicles</option>
                            <option value="boss">Boss</option>
                            <option value="shop">Shop</option>
                            <option value="wardrobe">Wardrobe</option>
                        </select>
                        <div class="button actualcoords" style="position: relative;" num="${markers}" id="markere-${markers}-button" style="background-color: red;"><span class="text" style="font-size: .4vw;">Actual coords</span></div>
                        <div class="button actualcoords" style="position: relative;" num="${markers}" id="markeredelete-${markers}-button" style="background-color: red;"><span class="text" style="font-size: .4vw;">Delete</span></div>
                    </div>  
                `)
                $(`#markere-${markers}-selected`).val(val.selected);
                $(`#markere-${markers}-button`).on("click", async function() {
                    
                    let coords = await JOB.ExecuteCallback("getCoords")
                    let actualMarker = $(this).attr("num")
                    let axis = ['x', 'y', 'z']
                    axis.forEach((ax) => {
                        $(`#markere-${actualMarker}-${ax}`).val(coords[ax])
                    })
                })
                $(`#markeredelete-${markers}-button`).on("click", function() {
                    let actualMarker = $(this).attr("num")
                    $(`#markers-${actualMarker}`).remove()
                })
            })
            let vehicles = 0
            value['publicvehicles'].forEach((val) => {
                vehicles++
                $(`#vehicles-${key}`).append(`              
                    <input class="text" id="veh-${vehicles}-${key}" style="color: black; text-align: center; width: 50%; font-size: 0.8vw;" placeholder="Vehicle" value="${val}"></input>
                    <div style="background-color: red" class="save" num="${vehicles}" id="delete-vehicles-${key}-${vehicles}"><span class="text" style="font-size: .7vw;">Delete</span></div>       
                `)
                $(`#delete-vehicles-${key}-${vehicles}`).on("click", function() {
                    let actualVeh = $(this).attr("num")
                    $(`#veh-${actualVeh}-${key}`).remove()
                    $(this).remove()
                })
            })

            $(`#add-vehicle-${key}`).on("click", function() {
                vehicles++
                $(`#vehicles-${key}`).append(`              
                    <input class="text" id="veh-${vehicles}-${key}" style="color: black; text-align: center; width: 50%; font-size: 0.8vw;" placeholder="Vehicle" value=""></input>
                    <div style="background-color: red" class="save" num="${vehicles}" id="delete-vehicles-${key}-${vehicles}"><span class="text" style="font-size: .7vw;">Delete</span></div>
                `)
                $(`#delete-vehicles-${key}-${vehicles}`).on("click", function() {
                    let actualVeh = $(this).attr("num")
                    $(`#veh-${actualVeh}-${key}`).remove()
                    $(this).remove()
                })
            })

            $(`#save-vehicles-${key}`).on("click", function() {
                let Data = []
                for (var i = 1; i <= vehicles; i++) {
                    if ($(`#veh-${i}-${key}`).val()) {
                        Data.push($(`#veh-${i}-${key}`).val())
                    }
                }
                JOB.ExecuteCallback("updateInfo", Data, "updateVehicles", key)
            })

            $(".dropdown-toggle").on("click", function() {
                var isExpanded = $(this).attr("aria-expanded")
                let that = this
                if (isExpanded === "false") {
                    
                } else {
                    setTimeout(() => {
                        $(that).removeClass("collapse")
                    }, 358);
                }
            })


            $(`#save-markers-${key}`).on("click", function() {
                let Data = []
                for (var i = 1; i <= markers; i++) {
                    if ($(`#markere-${i}-x`).val()) {
                        let toInsert = {
                            Job: key,
                            x: $(`#markere-${i}-x`).val(),
                            y: $(`#markere-${i}-y`).val(),
                            z: $(`#markere-${i}-z`).val(),
                            selected: $(`#markere-${i}-selected`).val(),
                        }
                        Data.push(toInsert)
                    }
                }
                JOB.ExecuteCallback("updateInfo", Data, "updateMarkers", key)
            })


        })
    }



}

window.addEventListener("load", this.handleLoad)