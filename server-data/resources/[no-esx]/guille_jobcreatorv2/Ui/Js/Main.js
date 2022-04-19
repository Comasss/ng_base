handleLoad = () => {
    const JOB = []
    let blipsIncluded = 0
    let markersIncluded = 0
    let ranksIncluded = 0
    let showing = "home"
    let items = ["home", "add", "edit", "setting"]
    document.getElementById("home").style.color = "#7587fb"
    items.forEach((val) => {
        document.getElementById(val).addEventListener("click", () => {
            document.getElementById(val).style.color = "#7587fb"
            items.forEach((val2) => {
                if (!(val2 === val)) {
                    document.getElementById(val2).style.color = "white"
                }
            })
        })
    })

    JOB.ExecuteCallback = async function(name, data) {
        return new Promise(resolve => {
            $.post(`https://${GetParentResourceName()}/`+name, JSON.stringify({data: data}), function(result) {
                resolve(JSON.parse(result))
            })
        })
    }

    $.get("https://raw.githubusercontent.com/guillerp8/jobcreatorversion/ma/jobcreatorv2.json", function(v) {
        let versions = JSON.parse(v)
        versions.forEach((parsed) => {
            $(".patch-notes-wrapper").append(`
                <div class="patch-notes">
                    <span class="text patch-notes-title" style="font-size: .6vw; margin-top: -0.3vw;">${parsed.title} <strong>${parsed.number}</strong></span>
                    <div style="height: auto; position: absolute; margin-left: 4vw; margin-top: -0.3vw;"> 
                        <span class="text patch-notes-text">${parsed.text}</span>
                    </div>    
                </div>
            `)
        })
    })

    window.addEventListener("keydown", function(e) {
        if (e.key === "Escape") {
            JOB.ExecuteCallback("exit")
            $(".main-wrapper").fadeOut(200)
            $(".job-wrapper").remove()
        }
    })

    window.addEventListener("message", function (e) {  
        switch(e.data.type) {
            case "open":
                $(".main-wrapper").fadeIn(100)
        }
    })

    $("#home").on("click", () => {
        if (showing === "home") { return }
        $("#"+showing+"-wrapper").fadeOut(200)
        showing = "home"
        setTimeout(() => {
            $("#"+showing+"-wrapper").fadeIn(200) 
        }, 200);
    })

    $("#add").on("click", () => {
        if (showing === "add") { return }
        $("#"+showing+"-wrapper").fadeOut(200)
        showing = "add"
        setTimeout(() => {
            $("#"+showing+"-wrapper").fadeIn(200) 
        }, 200);
    })

    $("#edit").on("click", () => {
        if (showing === "edit") { return }
        $("#"+showing+"-wrapper").fadeOut(200)
        showing = "edit"
        setTimeout(() => {
            $("#"+showing+"-wrapper").fadeIn(200) 
        }, 200);
    })

    $(".addblip").on("click", function () {  
        blipsIncluded++
        $("#blippart").append(`
            <div id="blip-${blipsIncluded}" num="${blipsIncluded}" style="margin-top: 1vw">
                <input class="input blipin" num="${blipsIncluded}" id="blip-${blipsIncluded}-x" placeholder="X"></input>
                <input class="input blipin" num="${blipsIncluded}" id="blip-${blipsIncluded}-y" placeholder="Y"></input>
                <input class="input blipin" num="${blipsIncluded}" id="blip-${blipsIncluded}-z" placeholder="Z"></input>
                <input class="input blipin" num="${blipsIncluded}" id="blip-${blipsIncluded}-text" placeholder="Text"></input>
                <input class="input blipin" num="${blipsIncluded}" id="blip-${blipsIncluded}-color" placeholder="Color"></input>
                <input class="input blipin" num="${blipsIncluded}" id="blip-${blipsIncluded}-sprite" placeholder="Sprite"></input>
                <div id="blip-${blipsIncluded}-button" num="${blipsIncluded}" class="button actualcoords blip-actualcoords"><span class="text" style="font-size: .4vw;">Actual coords</span></div>
            </div>
        `)
        $(`#blip-${blipsIncluded}-button`).on("click", async function () {  
            let coords = await JOB.ExecuteCallback("getCoords")
            let axis = ['x', 'y', 'z']
            let actualMarker = $(this).attr("num")
            axis.forEach((ax) => {
                $(`#blip-${actualMarker}-${ax}`).val(coords[ax])
            })
        })
    })


    $("#addmarker").on("click", function () {  
        markersIncluded++
        $("#markerpart").append(`
            <div style="margin-top: 1vw" num="${markersIncluded}" id="marker-${markersIncluded}">
                <input class="input blipin" num="${markersIncluded}" id="marker-${markersIncluded}-x" placeholder="X"></input>
                <input class="input blipin" num="${markersIncluded}" id="marker-${markersIncluded}-y" placeholder="Y"></input>
                <input class="input blipin" num="${markersIncluded}" id="marker-${markersIncluded}-z" placeholder="Z"></input>
                <select num="${markersIncluded}" id="${markersIncluded}-selected" style="width: 2vw;"><option value="armory">Armario</option><option value="getvehs">Sacar coches</option><option value="savevehs">Guardar vehículos</option><option value="boss">Jefe</option><option value="shop">Tienda</option></select>
                <div class="button actualcoords" num="${markersIncluded}" id="marker-${markersIncluded}-button" style="background-color: red;"><span class="text" style="font-size: .4vw;">Actual coords</span></div>
            </div>
        `)
        $(`#marker-${markersIncluded}-button`).on("click", async function () {  
            let coords = await JOB.ExecuteCallback("getCoords")
            let actualMarker = $(this).attr("num")
            let axis = ['x', 'y', 'z']
            axis.forEach((ax) => {
                $(`#marker-${actualMarker}-${ax}`).val(coords[ax])
            })
        })
    })

    $("#rankbutton").on("click", function () {  
        ranksIncluded++
        $("#rankpart").append(`
            <div num="${ranksIncluded}" is-boss="false" id="rank-${ranksIncluded}" style="margin-top: 1vw">
                <input num="${ranksIncluded}" id="rank-${ranksIncluded}-name" class="input blipin" placeholder="Name"></input>
                <input num="${ranksIncluded}" id="rank-${ranksIncluded}-label" class="input blipin" placeholder="Label"></input>
                <div num="${ranksIncluded}" id="rank-${ranksIncluded}-boss" class="button actualcoords" style="background-color: red;"><span class="text" style="font-size: .4vw;">Boss</span></div>
            </div>
        `)
        $(`#rank-${ranksIncluded}-boss`).on("click", function() {
            const num = $(this).attr("num")
            const parent = $(`#rank-${num}`).attr("is-boss");
            if (parent === "false") {
                $(`#rank-${num}`).attr("is-boss", "true");
                $(`#rank-${num}-boss`).css("background-color", "green")
            } else {
                $(`#rank-${num}`).attr("is-boss", "false");
                $(`#rank-${num}-boss`).css("background-color", "red")
            }
        })
    })

    $(".confirm-button").on("click", function() {
        let initialData = {
            name: $(".jobname").val(),
            label: $(".joblabel").val(),
            blips: [],
            markers: [],
            ranks: [],
        }
        for (var i = 1; i <= blipsIncluded; i++) {
            let toInsert = {
                x: $(`#blip-${i}-x`).val(),
                y: $(`#blip-${i}-y`).val(),
                z: $(`#blip-${i}-z`).val(),
                color: $(`#blip-${i}-color`).val(),
                text: $(`#blip-${i}-text`).val(),
                sprite: $(`#blip-${i}-sprite`).val(),
            }
            initialData.blips.push(toInsert)
        }
        for (var i = 1; i <= markersIncluded; i++) {
            let toInsert = {
                x: $(`#marker-${i}-x`).val(),
                y: $(`#marker-${i}-y`).val(),
                z: $(`#marker-${i}-z`).val(),
                selected: $(`#${i}-selected`).val(),
            }
            initialData.markers.push(toInsert)
        }
        for (var i = 1; i <= ranksIncluded; i++) {
            let toInsert = {
                name: $(`#rank-${i}-name`).val(),
                label: $(`#rank-${i}-label`).val(),
                isBoss: $(`#rank-${i}`).attr("is-boss"),
            }
            initialData.ranks.push(toInsert)
        }
        JOB.ExecuteCallback("createJob", initialData)
    })

    $(".dropdown-toggle").on("click", function() {
        var isExpanded = $(this).attr("aria-expanded")
        let that = this
        if (isExpanded === "false") {
            
        } else {
            setTimeout(() => {
                console.log("remove")
                $(that).removeClass("collapse")
            }, 358);
        }
    })


}



window.addEventListener("load", this.handleLoad)

