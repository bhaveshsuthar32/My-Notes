import { BrowserRouter, Route, Routes } from "react-router-dom"
import Home from "./user/pages/home"
import Reg_Form from "./admin/registration"
import User from "./admin/registration/user"
import View_Notes from "./user/pages/topics/view_notes"
import View_Lession from "./user/pages/topics/view_lession"
import View_Topic from "./user/pages/topics/view_topic"
import Login from "./admin/login"
import Add_Notes from "./admin/notes-form"
import All_Notes from "./user/pages/notes_list/allnotes"
import Notes from "./user/pages/notes_details/notes"
import Dashboard from "./admin/dashboard"

function App() {
  
  return (
    <>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/reg-form" element={ <Reg_Form />} />
          <Route path="/get-userData" element={<User />} />
          <Route path="/view-notes" element={<View_Notes />} />
          <Route path="/view-lession" element={<View_Lession />} />
          <Route path="/view-topic" element={<View_Topic />} />
          <Route path="/login" element={<Login />} />
          <Route path="/add-notes" element={<Add_Notes />} />
          <Route path="/all-notes" element={<All_Notes />}/>
          <Route path="/notes" element={<Notes />} />
          <Route path="/dashboard" element={<Dashboard />}/>
        </Routes>
      </BrowserRouter>
     
    </>
  )
}

export default App
